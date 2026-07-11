import SwiftUI

struct LandingView: View {
    @AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding: Bool = false
    
    var body: some View {
        Group {
            if hasCompletedOnboarding {
                PromptView()
            } else {
                OnboardingView()
            }
        }
    }
}

struct PromptView: View {
    @StateObject var viewModel = PromptViewModel()
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                Image(viewModel.selectedVerb.imageBackground)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack(spacing: 80) {
                    Text("Tap the cards to choose a subject and verb, then press Start.")
                        .font(Font.largeTitle.bold())
                    
                    HStack(spacing: 64) {
                        PromptCard(cardTitle: "Verb", promptImage: viewModel.selectedVerb.image, promptName: viewModel.selectedVerb.name) {
                            viewModel.shuffleVerb()
                        }
                        
                        PromptCard(cardTitle: "Subject", promptImage: viewModel.selectedSubject.image, promptName: viewModel.selectedSubject.name) {
                            viewModel.shuffleSubject()
                        }
                    }
                    
                    ActionButtons(viewModel: viewModel)
                }
            }
        }
        .environmentObject(viewModel)
    }
}

#Preview {
    LandingView()
}
