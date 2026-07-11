import SwiftUI

struct PromptGuideCard: View {
    let id = UUID()
    let promptImage: String
    let promptName: String
    
    var body: some View {
        ZStack{
//            RoundedRectangle(cornerRadius: 24)
//                .fill(.clear)
//                .background(
//                    RoundedRectangle(cornerRadius: 24)
//                        .fill(.ultraThinMaterial)
//                )
//                .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
//            
            VStack{
                Image(promptImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                
                Text(promptName)
                    .font(.title)
                    .bold()
                    .padding(8)
            }
            .shadow(color: Color.white.opacity(0.5), radius: 8, x: 0, y: 4)
            
        }
        .frame(width: 280, height: 360)
        
    }
}

#Preview {
    PromptGuideCard(promptImage: "Panda", promptName: "Panda")
}
