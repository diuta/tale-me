import AVFoundation
import SwiftUI

struct CameraLayerView: UIViewRepresentable {
    let session: AVCaptureSession

    func makeUIView(context: Context) -> PreviewUIView {
        let view = PreviewUIView()
        view.videoPreviewLayer.session = session
        view.videoPreviewLayer.videoGravity = .resizeAspectFill
        return view
    }

    func updateUIView(_ uiView: PreviewUIView, context: Context) {}

    final class PreviewUIView: UIView {
        override class var layerClass: AnyClass { AVCaptureVideoPreviewLayer.self }
        var videoPreviewLayer: AVCaptureVideoPreviewLayer {
            layer as! AVCaptureVideoPreviewLayer
        }

        override func layoutSubviews() {
            super.layoutSubviews()
            applyRotation()
        }

        private func applyRotation() {
            guard let connection = videoPreviewLayer.connection,
                  connection.isVideoRotationAngleSupported(0) else { return }
            connection.videoRotationAngle = 0
        }
    }
}

struct CameraBubbleView: View {
    @ObservedObject var cameraService: CameraService

    var body: some View {
        VStack(spacing: 36) {
            ZStack(alignment: .bottom) {
                ZStack {
                    CameraLayerView(session: cameraService.session)

                    if cameraService.isCameraOff {
                        Circle()
                            .fill(Color.black)
                            .overlay(
                                Image(systemName: "video.slash.fill")
                                    .font(.title)
                                    .foregroundColor(.white)
                            )
                    }
                }
                .frame(width: 220, height: 220)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                .shadow(color: .black.opacity(0.15), radius: 6, y: 3)

                HStack(spacing: 4) {
                    Image(systemName: "record.circle").foregroundColor(.red)
                    Text(cameraService.formattedElapsedTime)
                        .font(.body).bold().foregroundColor(.black)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(Capsule().fill(.ultraThinMaterial))
                .offset(y: 8)
            }

            HStack(spacing: 16) {
                Button {
                    cameraService.toggleMute()
                } label: {
                    Image(systemName: cameraService.isMuted ? "microphone.slash.fill" : "microphone.fill")
                        .frame(width: 32, height: 32)
                }
                .buttonStyle(.glass)

                Button {
                    cameraService.toggleCamera()
                } label: {
                    Image(systemName: cameraService.isCameraOff ? "video.slash.fill" : "video.fill")
                        .frame(width: 32, height: 32)
                }
                .buttonStyle(.glass)
            }
        }
    }
}

#Preview {
    CameraBubbleView(cameraService: CameraService())
        .preferredColorScheme(.dark)
}
