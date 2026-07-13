//
//  CameraService.swift
//  sengkuyung
//
//  Created by Dimas Putra Aryawan on 10/07/26.
//

import Foundation
import AVFoundation
import Combine
import SwiftUI
import SwiftData

class CameraService: NSObject, ObservableObject {
    let session = AVCaptureSession()
    let movieOutput = AVCaptureMovieFileOutput()
    let storageService = StorageService()
    
    var currentRecordingURL: URL?
    
    @Published var isCameraOff = false
    @Published var isMuted = false
    @Published var formattedElapsedTime = "00:00"
    @Published var isSaveComplete = false
    
    private var timer: Timer?
    private var recordingDuration = 0
    private var selectedSubject: SubjectPrompt?
    private var selectedVerb: VerbPrompt?
    private var modelContext: ModelContext?
    private var isRestartPending = false
    
    // MARK: - Setup Orchestration
    func setupCamera() {
        session.beginConfiguration()
        
        session.sessionPreset = .high
        configureHardware()
        configureOutput()
        
        session.commitConfiguration()
        
        Task(priority: .background) {
            
            self.session.startRunning()
            
            try? await Task.sleep(nanoseconds: 500_000_000)
            
            await MainActor.run {
                self.startRecording()
            }
        }
    }
    
    // MARK: - Private Configuration Steps
    private func configureHardware() {
        if let frontCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front),
           let cameraInput = try? AVCaptureDeviceInput(device: frontCamera) {
            
            if session.canAddInput(cameraInput) {
                session.addInput(cameraInput)
            }
        }
        
        if let microphone = AVCaptureDevice.default(for: .audio),
           let audioInput = try? AVCaptureDeviceInput(device: microphone) {
            
            if session.canAddInput(audioInput) {
                session.addInput(audioInput)
            }
        }
    }
    
    private func configureOutput() {
        if session.canAddOutput(movieOutput) {
            session.addOutput(movieOutput)
        }
    }
    
    // MARK: - Recording Logic
    private func getTempVideoFolder() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let tempDir = paths[0].appendingPathComponent("Temps")
        
        if !FileManager.default.fileExists(atPath: tempDir.path) {
            try? FileManager.default.createDirectory(at: tempDir, withIntermediateDirectories: true)
        }
        return tempDir
    }
    
    func startRecording() {
        let fileName = "\(UUID().uuidString).mov"
        let fileURL = getTempVideoFolder().appendingPathComponent(fileName)
        self.currentRecordingURL = fileURL
        
        recordingDuration = 0
        formattedElapsedTime = "00:00"
        self.isSaveComplete = false
        startTimer()
        
        if let videoConnection = movieOutput.connection(with: .video) {
            if videoConnection.isVideoRotationAngleSupported(0) {
                videoConnection.videoRotationAngle = 0
            }
        }
        
        movieOutput.startRecording(to: fileURL, recordingDelegate: self)
    }
    
    func stopRecording() {
        if movieOutput.isRecording || movieOutput.isRecordingPaused {
            movieOutput.stopRecording()
        }
        timer?.invalidate()
        timer = nil
    }
    
    func saveRecording(subject: SubjectPrompt, verb: VerbPrompt, modelContext: ModelContext) {
        self.selectedSubject = subject
        self.selectedVerb = verb
        self.modelContext = modelContext
        
        self.stopRecording()
    }
    
    func restartRecording() {
        isRestartPending = true
        
        if movieOutput.isRecording {
            movieOutput.stopRecording()
        } else {
            performRestart()
        }
        
        timer?.invalidate()
        timer = nil
    }
    
    private func performRestart() {
        isRestartPending = false
        if let url = currentRecordingURL {
            print("removing \(url)")
            try? FileManager.default.removeItem(at: url)
        }
        startRecording()
    }
    
    func pauseRecording() {
        if movieOutput.isRecording {
            movieOutput.pauseRecording()
        }
        
        timer?.invalidate()
        timer = nil
    }
    
    func resumeRecording() {
        guard movieOutput.isRecordingPaused else { return }
        movieOutput.resumeRecording()
        startTimer()
    }
    
    // MARK: - UI
    func toggleCamera() {
        isCameraOff.toggle()
        
        session.beginConfiguration()
        if let videoConnection = movieOutput.connection(with: .video) {
            videoConnection.isEnabled = !isCameraOff
        }
        session.commitConfiguration()
    }
    
    func toggleMute() {
        isMuted.toggle()
        
        session.beginConfiguration()
        if let audioConnection = movieOutput.connection(with: .audio) {
            audioConnection.isEnabled = !isMuted
        }
        session.commitConfiguration()
    }
    
    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.recordingDuration += 1
            
            let minutes = self.recordingDuration / 60
            let seconds = self.recordingDuration % 60
            self.formattedElapsedTime = String(format: "%02d:%02d", minutes, seconds)
        }
    }
}

// MARK: - Delegate Extension
extension CameraService: AVCaptureFileOutputRecordingDelegate {
    
    func fileOutput(_ output: AVCaptureFileOutput, didStartRecordingTo fileURL: URL, from connections: [AVCaptureConnection]) {
        print("lagi record neh")
    }
    
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        print("2")
        if isRestartPending {
            isRestartPending = false
            performRestart()
            print("3")
            return
        }
        
        if let error = error {
            print("Failed to record: \(error.localizedDescription)")
            return
        }
        
        guard let videoURL = currentRecordingURL else {
            print("No video to save")
            return
        }
        
        guard let subject = selectedSubject,
              let verb = selectedVerb,
              let context = modelContext else {
            print("No prompt data")
            return
        }
        
        print("4")
        
        DispatchQueue.main.async {
            do {
                try self.storageService.saveHistory(from: videoURL, subject: subject, verb: verb, context: context)
                self.isSaveComplete = true
            } catch {
                print("err: \(error)")
            }
        }
    }
}
