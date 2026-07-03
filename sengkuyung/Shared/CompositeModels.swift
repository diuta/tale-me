
import Foundation

struct SubjectPrompt: Identifiable {
    let id: UUID
    let name: String
    let image: String
}

struct ActionPrompt: Identifiable {
    let id: UUID
    let name: String
    let image: String
    let imageBackground: String
}
