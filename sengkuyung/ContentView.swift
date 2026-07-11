import SwiftUI
import SwiftData

struct ContentView: View {
    @Query private var hists: [HistoryData]
    let storageService = StorageService()
    @Environment(\.modelContext) var context

    var body: some View {
        Button(action: {
            storageService.deleteAllHistory(context: context)
        }) {
            Text("Delete All Data")
                .foregroundColor(.red)
        }
        
        List(hists) { hist in
            Text(hist.videoName ?? "Unknown Video")
        }
        .onAppear {
            print("--- Saved History (\(hists.count)) ---")
            for hist in hists {
                print("ID: \(hist.historyID) | Video: \(hist.videoName ?? "nil") | Date: \(hist.historyDate)")
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: HistoryData.self, inMemory: true)
}
