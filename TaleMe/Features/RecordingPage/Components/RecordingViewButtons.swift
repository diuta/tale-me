import SwiftUI

struct RecordingViewButtons: View {
    var onPause: () -> Void = {}
    var onFinish: () -> Void = {}
    
    var body: some View {
        
        HStack(spacing: 16) {
            Button {
                onPause()
            } label: {
                HStack(spacing: 8) {
                    Image(systemName: "pause.fill")
                    Text("Pause")
                }
                .foregroundColor(.black)
                .padding(.horizontal, 24)
                .padding(.vertical, 8)
            }
            .buttonStyle(.glass)
            
            Button {
                onFinish()
            } label: {
                HStack(spacing: 8) {
                    Image(systemName: "flag.checkered")
                    Text("Finish")
                }
                .foregroundColor(.white)
                .padding(.horizontal, 24)
                .padding(.vertical, 8)
            }
            .buttonStyle(.borderedProminent)
        }
        
    }
}

#Preview {
    RecordingViewButtons()
}
