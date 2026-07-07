
import Foundation

struct SubjectPrompt: Identifiable {
    let id: UUID
    let name: String
    let image: String
}

struct VerbPrompt: Identifiable {
    let id: UUID
    let name: String
    let image: String
    let imageBackground: String
}
