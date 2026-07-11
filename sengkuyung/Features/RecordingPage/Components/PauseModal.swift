import SwiftUI

struct PauseModal: View {
    var onResume: () -> Void = {}
    var onRestart: () -> Void = {}
    var onHome: () -> Void = {}
    
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                Text("Paused")
                    .font(.system(size: 36))
                    .fontWeight(.bold)
                    .foregroundStyle(Color("LightText"))
                
            }
            .frame(width: 400, height: 100)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 38))
            .position(x: 603, y: 230)
            .shadow(color: .black.opacity(0.18), radius: 75, x: 0, y: 15)
            .zIndex(10)
                
            
            VStack(spacing: 16) {
                Button {
                    onResume()
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "play.fill")
                        Text("Resume")
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 6)
                }
                .buttonStyle(.glassProminent)
                .tint(Color("LightText"))
                
                
                Button {
                    onRestart()
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "arrow.clockwise")
                        Text("Restart Recording")
                    }
                    .foregroundColor(.black)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 6)
                }
                .buttonStyle(.glass)
                
                Button {
                    onHome()
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                    .foregroundColor(.black)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 6)
                }
                .buttonStyle(.glass)
            }
            .padding(.top, 72)
            .padding(.bottom, 32)
            .frame(width: 466, height: 304)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 38))
            .shadow(color: .black.opacity(0.18), radius: 75, x: 0, y: 15)
        }
    }
}

#Preview {
    PauseModal()
}
