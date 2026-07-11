//
//  DataManager.swift
//  sengkuyung
//
//  Created by Dimas Putra Aryawan on 08/07/26.
//

import Foundation
import SwiftData
import AVFoundation
import UIKit

class StorageService {
    func getDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let historyDir = paths[0].appendingPathComponent("HistoryRecordings")
        
        if !FileManager.default.fileExists(atPath: historyDir.path) {
            try? FileManager.default.createDirectory(at: historyDir, withIntermediateDirectories: true)
        }
        
        return historyDir
    }
    
    private func extractThumbnail(from videoURL: URL) -> Data? {
        let asset = AVURLAsset(url: videoURL)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        
        imageGenerator.appliesPreferredTrackTransform = true
        
        let time = CMTime(seconds: 0.5, preferredTimescale: 600)
        
        do {
            let cgImage = try imageGenerator.copyCGImage(at: time, actualTime: nil)
            let uiImage = UIImage(cgImage: cgImage)
            
            return uiImage.jpegData(compressionQuality: 0.8)
        } catch {
            print("Failed to generate thumbnail: \(error.localizedDescription)")
            return nil
        }
    }
    
    func saveHistory(from temporaryURL: URL, subject: SubjectPrompt, verb: VerbPrompt, context: ModelContext, isVideo: Bool = true) throws {
        let newId = UUID()
        
        if !isVideo {
            let newHistory = HistoryData(historyID: newId, subject: subject, verb: verb, videoName: nil, thumbnailName: nil)
            context.insert(newHistory)
            
            return
        }
        
        let videoName = "\(newId.uuidString).mov"
        let thumbnailName = "\(newId.uuidString).jpg"
        
        let saveVideoUrl = getDirectory().appendingPathComponent(videoName)
        try FileManager.default.moveItem(at: temporaryURL, to: saveVideoUrl)
        let thumbnail = extractThumbnail(from: saveVideoUrl)
        let saveThumbnailUrl = getDirectory().appendingPathComponent(thumbnailName)
        FileManager.default.createFile(atPath: saveThumbnailUrl.path, contents: thumbnail)
        
        let newHistory = HistoryData(historyID: newId, subject: subject, verb: verb, videoName: videoName, thumbnailName: thumbnailName)
        context.insert(newHistory)
        
        print("saved")
        
        return
    }
    
    func deleteAllHistory(context: ModelContext) {
        
        let historyDir = getDirectory()
        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: historyDir, includingPropertiesForKeys: nil)
            
            for fileURL in fileURLs {
                try FileManager.default.removeItem(at: fileURL)
            }
            print("Success: Wiped all physical video and thumbnail files.")
            
        } catch {
            print("Error: Could not wipe physical files: \(error.localizedDescription)")
        }
        
        do {
            try context.delete(model: HistoryData.self)
            
            try context.save()
            print("Success: Wiped the SwiftData database.")
            
        } catch {
            print("Error: Could not wipe database: \(error.localizedDescription)")
        }
    }
}

