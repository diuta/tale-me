import SwiftUI
import SwiftData

struct ContentView: View {
    @Query private var hists: [HistoryData]
    let storageService = StorageService()
    @Environment(\.modelContext) var context

    var body: some View {
       PromptView()
    }
}

#Preview(traits: .landscapeLeft) {
    ContentView()
        .modelContainer(for: HistoryData.self, inMemory: true)
}
