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
    
    var body: some View {
        ZStack {
            Image(viewModel.selectedAction.imageBackground)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(spacing: 80) {
                Text("Pick a Tale")
                    .font(Font.largeTitle.bold())
                
                HStack(spacing: 64) {
                    PromptCard(cardTitle: "Verb", promptImage: viewModel.selectedAction.image, promptName: viewModel.selectedAction.name) {
                        viewModel.shuffleAction()
                    }
                    
                    PromptCard(cardTitle: "Subject", promptImage: viewModel.selectedSubject.image, promptName: viewModel.selectedSubject.name) {
                        viewModel.shuffleSubject()
                    }
                }
                
                ActionButtons(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    LandingView()
}
