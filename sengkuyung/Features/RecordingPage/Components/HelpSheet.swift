import SwiftUI

struct HelpSheet: View {
    let id = UUID()
    let helpPrompt: String
    
    var body: some View {
        
        HStack {
            Image(systemName: "info.circle")
            
            Text("" + helpPrompt)
                .font(.title2)
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 16)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 26))
        
    }
}

#Preview {
    HelpSheet(helpPrompt: "What would the color be?")
    //        .preferredColorScheme(.dark)
}
