import Foundation
import SwiftUI
import Combine

class PromptViewModel: ObservableObject {
    @Published var selectedSubject: SubjectPrompt
    @Published var selectedVerb: VerbPrompt

    init() {
        self.selectedSubject = SubjectPrompt.sampleSubjects.randomElement() ?? SubjectPrompt(id: UUID(), name: "Default Subject", image: "Panda")
        self.selectedVerb = VerbPrompt.sampleVerb.randomElement() ?? VerbPrompt(id: UUID(), name: "Default Action", image: "action_eating", imageBackground: "bg_eating")
    }

    func shuffleSubject() {
        let availableSubjects = SubjectPrompt.sampleSubjects.filter {$0.id != selectedSubject.id}
        if let newSubject = availableSubjects.randomElement() {
            self.selectedSubject = newSubject
        }
    }

    func shuffleVerb() {
        let availableAction = VerbPrompt.sampleVerb.filter {$0.id != selectedVerb.id}
        if let newAction = availableAction.randomElement() {
            self.selectedVerb = newAction
        }
    }
    
    func shuffleBoth() {
        shuffleSubject()
        shuffleVerb()
    }
}
