import SwiftUI

struct DialogBox: View {
    @EnvironmentObject var viewModel : PromptViewModel
    
    var body: some View {
        ZStack (alignment: .bottom){

            Image("tale_membaca")
                .resizable()
                .scaledToFit()
                .frame(width: 224)
                .offset(y: -100)
                .shadow(color: .black.opacity(0.25), radius: 16, x: 0, y: 8)
            
            VStack(spacing: 16) {
                Text("There was ^[a \(viewModel.selectedVerb.name)](inflect: true) \(viewModel.selectedSubject.name) ")
                    .fontWeight(.bold)
                    .font(.system(size: 32))
                    .foregroundStyle(.lightText)
                
                Text("Now, you will work together to create a story from the provided images.")
                    .fontWeight(.regular)
                    .font(.system(size: 32))
                    .foregroundStyle(.lightText)
                
                NavigationLink {
                    RecordingView()
                } label: {
                    Text("Tap to continue")
                        .font(.system(size: 24))
                        .underline()
                }
                .buttonStyle(.borderless)
                .padding(.top, 24)
            }
            .padding(.vertical, 24)
            .frame(width: 1138, height: 244)
            .background(.white)
            .clipShape(UnevenRoundedRectangle(
                topLeadingRadius: 38,
                bottomLeadingRadius: 0,
                bottomTrailingRadius: 0,
                topTrailingRadius: 38
            ))
            .shadow(color: .black.opacity(0.18), radius: 75, x: 0, y: 15)
        }
    }
}

#Preview {
    DialogBox()
}
