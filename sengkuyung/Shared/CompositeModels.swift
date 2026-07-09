
import Foundation

struct SubjectPrompt: Identifiable, Codable {
    let id: UUID
    let name: String
    let image: String
}

struct VerbPrompt: Identifiable, Codable {
    let id: UUID
    let name: String
    let image: String
    let imageBackground: String
}
