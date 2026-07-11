
import Foundation
import SwiftData

@Model
class HistoryData {
    var historyID: UUID
    var subjectPrompt: SubjectPrompt
    var verbPrompt: VerbPrompt
    var historyDate: Date
    var videoURL: URL
    var thumbnailURL: URL
    
    init(historyID: UUID = UUID(), subject: SubjectPrompt, verb: VerbPrompt, date: Date = Date(), videoURL: URL, thumbnailURL: URL) {
        self.historyID = historyID
        self.subjectPrompt = subject
        self.verbPrompt = verb
        self.historyDate = date
        self.videoURL = videoURL
        self.thumbnailURL = thumbnailURL
    }
}
