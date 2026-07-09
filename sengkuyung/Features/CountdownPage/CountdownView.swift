import SwiftUI

struct CountdownView: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            Image("GradientBackground")
                .resizable()
            
            ChatBubble()
                .offset(x: 200, y: -375)
            
            DialogBox()
            
        }
        .ignoresSafeArea()
    }
}

#Preview {
    CountdownView()
}
