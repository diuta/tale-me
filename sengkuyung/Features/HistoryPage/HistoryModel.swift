
import Foundation
import SwiftData

struct HistoryModel {
    let id: UUID
    let title: String
    let date: Date
    
    let subject: String
    let verb: String
    
    let image: String
    let audio: String
    let note: String
}


@Model
class HistoryData {
    var historyID: UUID
    var subjectPrompt: SubjectPrompt
    var verbPrompt: VerbPrompt
    var historyDate: Date
    var videoName: String?
    var thumbnailName: String?
    
    init(historyID: UUID = UUID(), subject: SubjectPrompt, verb: VerbPrompt, date: Date = Date(), videoName: String? = nil, thumbnailName: String? = nil) {
        self.historyID = historyID
        self.subjectPrompt = subject
        self.verbPrompt = verb
        self.historyDate = date
        self.videoName = videoName
        self.thumbnailName = thumbnailName
    }
}
