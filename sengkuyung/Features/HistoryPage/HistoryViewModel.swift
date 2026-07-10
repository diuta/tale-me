//
//  HistoryViewModel.swift
//  sengkuyung
//

import Foundation
import SwiftUI
import SwiftData
import Combine

class HistoryViewModel: ObservableObject {

    enum Phase {
        case cover
        case tableOfContents
        case spread
        case detail
    }

    enum PageSlot: Identifiable {
        case journey(HistoryData)
        case placeholder

        var id: String {
            switch self {
            case .journey(let model): return model.historyID.uuidString
            case .placeholder: return "placeholder"
            }
        }
    }


    @Published var journeys: [HistoryData]
    @Published var phase: Phase = .cover
    @Published var pairIndex: Int = 0
    @Published var selectedJourney: HistoryData? = nil
    @Published var notesByJourney: [UUID: String] = [:]
    @Published var isEditingNotes = false


    init(initialJourneys: [HistoryData] = []) {
        self.journeys = initialJourneys
        
        //dummy
        // self.journeys = HistorySampleData.journeys
    }

    func loadJourneys(context: ModelContext) {
        let descriptor = FetchDescriptor<HistoryData>(sortBy: [SortDescriptor(\.historyDate, order: .forward)])
        do {
            journeys = try context.fetch(descriptor)
        } catch {
            print("Failed to fetch journeys: \(error.localizedDescription)")
            journeys = []
        }
        
        //dummy
        // journeys = HistorySampleData.journeys
    }

    var slots: [PageSlot] {
        journeys.map(PageSlot.journey) + [.placeholder]
    }

    var pairs: [[PageSlot]] {
        stride(from: 0, to: slots.count, by: 2).map { Array(slots[$0..<min($0 + 2, slots.count)]) }
    }

    var currentPair: [PageSlot] {
        guard !pairs.isEmpty else { return [] }
        return pairs[min(pairIndex, pairs.count - 1)]
    }

    func pageNumber(for slot: PageSlot) -> Int? {
        switch slot {
        case .journey(let journey):
            return journeys.firstIndex(where: { $0.historyID == journey.historyID }).map { $0 + 1 }
        case .placeholder:
            return nil
        }
    }

    func isMostRecent(_ journey: HistoryData) -> Bool {
        journey.historyID == journeys.last?.historyID
    }

    func title(for journey: HistoryData) -> String {
        "\(journey.verbPrompt.name) \(journey.subjectPrompt.name)"
    }

    func note(for journey: HistoryData) -> String {
        notesByJourney[journey.historyID] ?? ""
    }

    func scheduleSplashTransition() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
            withAnimation { self.phase = .tableOfContents }
        }
    }

    func advanceFromTableOfContents() {
        withAnimation { phase = .spread }
    }

    func selectRow(id: UUID) {
        if let index = journeys.firstIndex(where: { $0.historyID == id }) {
            pairIndex = index / 2
        }
        withAnimation { phase = .spread }
    }

    func goToPreviousPair() {
        withAnimation {
            if pairIndex == 0 {
                phase = .tableOfContents
            } else {
                pairIndex -= 1
            }
        }
    }

    func goToNextPair() {
        withAnimation { pairIndex = min(pairIndex + 1, pairs.count - 1) }
    }

    var canGoToNextPair: Bool {
        pairIndex < pairs.count - 1
    }

    func viewDetails(for journey: HistoryData) {
        selectedJourney = journey
        withAnimation { phase = .detail }
    }

    func backToSpreadFromDetail() {
        phase = .spread
    }

    func startEditingNotes() {
        isEditingNotes = true
    }

    func cancelEditingNotes() {
        isEditingNotes = false
    }

    func confirmNotes(_ newText: String, for journey: HistoryData) {
        notesByJourney[journey.historyID] = newText
        isEditingNotes = false
    }
}
