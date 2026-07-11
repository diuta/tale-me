import SwiftUI
import AVFoundation
import SwiftData

struct RecordingView: View {
    @State private var centeredPropID: UUID?
    @State private var promptIndex: Int = 0
    @State private var isPaused = false
    @State private var isFinishRecording = false
    @State private var isNavigateHome = false
    @EnvironmentObject var promptViewModel : PromptViewModel
    @Environment(\.dismiss) private var dismiss
    @StateObject private var cameraService = CameraService()
    @Environment(\.modelContext) var context
    
    private var currentProp: helpPrompt? {
        let props = promptViewModel.selectedVerb.props
        return props.first(where: { $0.id == centeredPropID }) ?? props.first
    }
    
    private var currentHelpPrompt: String {
        guard let prop = currentProp, !prop.help.isEmpty else {
            return ""
        }
        let safeIndex = promptIndex % prop.help.count
        return prop.help[safeIndex]
    }
    
    var body: some View {
        ZStack {
            Image("\(promptViewModel.selectedVerb.imageBackground)")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack{
                Spacer()
                
                Text("\(promptViewModel.selectedVerb.name) \(promptViewModel.selectedSubject.name)")
                    .font(.largeTitle)
                    .padding(.horizontal, 36)
                    .padding(.vertical, 16)
                    .background(Capsule().fill(.ultraThinMaterial))
                
                HStack {
                    CameraBubbleView(cameraService: cameraService)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 46) {
                            ForEach(promptViewModel.selectedVerb.props) { prop in
                                PromptGuideCard(
                                    promptImage: prop.image,
                                    promptName: prop.name
                                )
                                .id(prop.id)
                                .scrollTransition(.interactive, axis: .horizontal) { content, phase in
                                    content
                                        .scaleEffect(phase.isIdentity ? 1.0 : 0.6)
                                        .blur(radius: phase.isIdentity ? 0 : 1.5)
                                        .opacity(phase.isIdentity ? 1 : 0.9)
                                }
                            }
                        }
                        .scrollTargetLayout()
                    }
                    .scrollTargetBehavior(.viewAligned(limitBehavior: .alwaysByOne))
                    .scrollPosition(id: $centeredPropID)
                    .contentMargins(.leading, 32, for: .scrollContent)
                    .contentMargins(.trailing, 455, for: .scrollContent)
                    .frame(maxWidth: .infinity, maxHeight: 400)
                }
                
                HelpSheet(helpPrompt: currentHelpPrompt)
                
                Spacer()
                
                RecordingViewButtons(
                    onPause: {
                        isPaused = true
                        cameraService.pauseRecording()
                    },
                    onFinish: {
                        cameraService.saveRecording(subject: promptViewModel.selectedSubject, verb: promptViewModel.selectedVerb, modelContext: context)
                    }
                )
                
                
                Spacer()
            }
            .padding(.horizontal, 100)
            
            if isPaused {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .transition(.opacity)
                
                PauseModal(
                    onResume: {
                        isPaused = false
                        cameraService.resumeRecording()
                    },
                    onRestart: {
                        isPaused = false
                        cameraService.restartRecording()
                    },
                    onHome: {
                        isPaused = false
                        isNavigateHome = true
                    }
                )
                .transition(.scale.combined(with: .opacity))
            }
            
        }
        .navigationBarBackButtonHidden()
        .navigationDestination(isPresented: $cameraService.isSaveComplete) {
            HistoryView(onDismiss: {
                    cameraService.isSaveComplete = false
                })
        }
        .navigationDestination(isPresented: $isNavigateHome) {
            PromptView()
        }
        .task {
            cameraService.setupCamera()
        }
        .onDisappear {
            cameraService.stopRecording()
            cameraService.session.stopRunning()
        }
    }
}
//
//#Preview {
//    RecordingView()
//        .environmentObject(PromptViewModel())
//}
