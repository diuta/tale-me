import SwiftUI

struct ChatBubble: View {
    var body: some View {
        ZStack {
            Image("ChatBubble")
                .shadow(color: .black.opacity(0.25), radius: 16, x: 0, y: 8)
            
            VStack(alignment: .leading, spacing: 12) {
                Text("Quick Tip")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Use open-ended questions such as what, why, how.")
                    .fontWeight(.regular)
                    .font(.system(size: 20))
            }
            .frame(width: 219)
            .rotationEffect(.degrees(10))
            .offset(y: -10)
        }
    }
}


#Preview {
    ChatBubble()
}
