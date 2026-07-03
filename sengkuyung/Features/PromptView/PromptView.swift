import SwiftUI
import ImagePlayground

struct AssetGeneratorView: View {
    @Environment(\.supportsImagePlayground) private var supportsImagePlayground

    @State private var subject = "elephant"
    @State private var verb = "fishing"
    @State private var isPresented = false
    @State private var generatedImageURL: URL?

    var concepts: [ImagePlaygroundConcept] {
        [.text(subject), .text(verb)]
    }

    var body: some View {
        VStack(spacing: 16) {
            TextField("Subject", text: $subject)
                .textFieldStyle(.roundedBorder)
            TextField("Verb", text: $verb)
                .textFieldStyle(.roundedBorder)

            if let generatedImageURL {
                AsyncImage(url: generatedImageURL) { image in
                    image.resizable().scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 250, height: 250)
            }

            Button("Generate Asset") {
                isPresented = true
            }
            .disabled(!supportsImagePlayground)
        }
        .padding()
        .imagePlaygroundSheet(
            isPresented: $isPresented,
            concepts: concepts,
            onCompletion: { url in
                generatedImageURL = url
            },
            onCancellation: {
                print("cancelled")
            }
        )
    }
}

#Preview {
    AssetGeneratorView()
}
