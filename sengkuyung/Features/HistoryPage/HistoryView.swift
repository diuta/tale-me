//
//  HistoryView.swift
//  sengkuyung
//
//  Created by Catherine Danielle on 09/07/26.
//


import SwiftUI

struct HistoryView: View {

    private enum Phase {
        case cover
        case tableOfContents
        case spread
        case detail
    }

    private enum PageSlot: Identifiable {
        case journey(HistoryData)
        case placeholder

        var id: String {
            switch self {
            case .journey(let model): return model.historyID.uuidString
            case .placeholder: return "placeholder"
            }
        }
    }

    var onDismiss: () -> Void = {}

    @State private var journeys: [HistoryData]
    @State private var phase: Phase = .cover
    @State private var pairIndex: Int = 0
    @State private var selectedJourney: HistoryData? = nil
    @State private var notesByJourney: [UUID: String] = [:]
    @State private var isEditingNotes = false

    init(initialJourneys: [HistoryData] = HistorySampleData.journeys, onDismiss: @escaping () -> Void = {}) {
        self._journeys = State(initialValue: initialJourneys)
        self.onDismiss = onDismiss
    }

    private var slots: [PageSlot] {
        journeys.map(PageSlot.journey) + [.placeholder]
    }

    private var pairs: [[PageSlot]] {
        stride(from: 0, to: slots.count, by: 2).map { Array(slots[$0..<min($0 + 2, slots.count)]) }
    }

    var body: some View {
        VStack(spacing: 24) {
            topBar

            Spacer(minLength: 0)

            content

            Spacer(minLength: 0)
        }
        .background(Color.white.ignoresSafeArea())
        .onAppear(perform: scheduleSplashTransition)
        .sheet(isPresented: $isEditingNotes) {
            if let journey = selectedJourney {
                NotesEditorSheet(
                    initialText: notesByJourney[journey.historyID] ?? "",
                    onCancel: { isEditingNotes = false },
                    onConfirm: { newText in
                        notesByJourney[journey.historyID] = newText
                        isEditingNotes = false
                    }
                )
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
            }
        }
    }

    @ViewBuilder
    private var topBar: some View {
        switch phase {
        case .cover:
            HistoryTopBar(leadingStyle: .home, showsTrailingMenu: false, onLeading: onDismiss)
        case .detail:
            HistoryTopBar(leadingStyle: .back, onLeading: { phase = .spread })
        case .tableOfContents, .spread:
            HistoryTopBar(leadingStyle: .home, onLeading: onDismiss)
        }
    }

    @ViewBuilder
    private var content: some View {
        switch phase {
        case .cover:
            BookCover()
        case .tableOfContents:
            BookSpreadContainer(
                showsNextChevron: true,
                onNext: { withAnimation { phase = .spread } }
            ) {
                JourneyBookIcon()
            } right: {
                TableOfContentsList(
                    rows: journeys.enumerated().map { index, journey in
                        TableOfContentsRow(
                            id: journey.historyID,
                            title: title(for: journey),
                            date: journey.historyDate,
                            isBookmarked: index == journeys.count - 1
                        )
                    },
                    onSelectRow: { row in
                        if let index = journeys.firstIndex(where: { $0.historyID == row.id }) {
                            pairIndex = index / 2
                        }
                        withAnimation { phase = .spread }
                    }
                )
            }

        case .spread:
            spreadView

        case .detail:
            if let journey = selectedJourney {
                detailView(for: journey)
            }
        }
    }

    @ViewBuilder
    private var spreadView: some View {
        if journeys.isEmpty {
            BookSpreadContainer {
                EmptyJourneyIllustration()
            } right: {
                PlaceholderJourneyCard(isMostRecent: true)
            }
        } else {
            let pair = pairs[min(pairIndex, pairs.count - 1)]
            let leftSlot = pair.first
            let rightSlot = pair.count > 1 ? pair[1] : nil

            BookSpreadContainer(
                leftPageNumber: leftSlot.flatMap(pageNumber),
                rightPageNumber: rightSlot.flatMap(pageNumber),
                showsPreviousChevron: true,
                showsNextChevron: pairIndex < pairs.count - 1,
                onPrevious: {
                    withAnimation {
                        if pairIndex == 0 {
                            phase = .tableOfContents
                        } else {
                            pairIndex -= 1
                        }
                    }
                },
                onNext: {
                    withAnimation { pairIndex = min(pairIndex + 1, pairs.count - 1) }
                }
            ) {
                slotView(leftSlot, ribbonEdge: .trailing)
            } right: {
                if let rightSlot {
                    slotView(rightSlot, ribbonEdge: .leading)
                } else {
                    Color.clear
                }
            }
        }
    }

    @ViewBuilder
    private func slotView(_ slot: PageSlot?, ribbonEdge: HorizontalEdge) -> some View {
        switch slot {
        case .journey(let journey):
            JourneyCard(
                title: title(for: journey),
                date: journey.historyDate,
                iconName1: journey.subjectPrompt.image,
                iconName2: journey.verbPrompt.image,
                isMostRecent: isMostRecent(journey),
                ribbonEdge: ribbonEdge,
                onViewDetails: {
                    selectedJourney = journey
                    withAnimation { phase = .detail }
                }
            )
        case .placeholder:
            PlaceholderJourneyCard(
                isMostRecent: true,
                ribbonEdge: ribbonEdge,
                onStartNewJourney: {
                    // TODO: kick off a new journey/session.
                }
            )
        case .none:
            Color.clear
        }
    }

    @ViewBuilder
    private func detailView(for journey: HistoryData) -> some View {
        BookSpreadContainer {
            JourneyDetailContent(
                title: title(for: journey),
                date: journey.historyDate,
                duration: "1h 3s",
                iconName1: journey.subjectPrompt.image,
                iconName2: journey.verbPrompt.image,
                isMostRecent: isMostRecent(journey)
            )
        } right: {
            JourneyMediaContent(
                imageName: journey.thumbnailName,
                isVideo: journey.videoName != nil,
                note: notesByJourney[journey.historyID] ?? "",
                onPlay: {
                    // TODO: play back the captured video.
                },
                onAddOrEditNotes: {
                    isEditingNotes = true
                }
            )
        }
    }

    private func pageNumber(for slot: PageSlot) -> Int? {
        switch slot {
        case .journey(let journey):
            return journeys.firstIndex(where: { $0.historyID == journey.historyID }).map { $0 + 1 }
        case .placeholder:
            return nil
        }
    }

    private func isMostRecent(_ journey: HistoryData) -> Bool {
        journey.historyID == journeys.last?.historyID
    }

    private func title(for journey: HistoryData) -> String {
        "\(journey.verbPrompt.name) \(journey.subjectPrompt.name)"
    }

    private func scheduleSplashTransition() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
            withAnimation { phase = .tableOfContents }
        }
    }
}

#Preview(traits: .landscapeLeft) {
    HistoryView()
}

//#Preview("Empty state", traits: .landscapeLeft) {
//    HistoryView(initialJourneys: [])
//}
