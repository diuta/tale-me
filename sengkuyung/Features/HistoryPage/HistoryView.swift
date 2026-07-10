//
//  HistoryView.swift
//  sengkuyung
//
//  Created by Catherine Danielle on 09/07/26.
//


import SwiftUI
import SwiftData

struct HistoryView: View {

    var onDismiss: () -> Void = {}

    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel: HistoryViewModel

    init(initialJourneys: [HistoryData] = [], onDismiss: @escaping () -> Void = {}) {
        self._viewModel = StateObject(wrappedValue: HistoryViewModel(initialJourneys: initialJourneys))
        self.onDismiss = onDismiss
    }

    var body: some View {
        VStack(spacing: 24) {
            topBar

            Spacer(minLength: 0)

            content

            Spacer(minLength: 0)
        }
        .background(Color.white.ignoresSafeArea())
        .onAppear {
            viewModel.loadJourneys(context: modelContext)
            
            //dummy
            // viewModel.journeys = HistorySampleData.journeys

            viewModel.scheduleSplashTransition()
        }
        .sheet(isPresented: $viewModel.isEditingNotes) {
            if let journey = viewModel.selectedJourney {
                NotesEditorSheet(
                    initialText: viewModel.note(for: journey),
                    onCancel: { viewModel.cancelEditingNotes() },
                    onConfirm: { newText in
                        viewModel.confirmNotes(newText, for: journey)
                    }
                )
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
            }
        }
    }

    @ViewBuilder
    private var topBar: some View {
        switch viewModel.phase {
        case .cover:
            HistoryTopBar(leadingStyle: .home, showsTrailingMenu: false, onLeading: onDismiss)
        case .detail:
            HistoryTopBar(leadingStyle: .back, onLeading: { viewModel.backToSpreadFromDetail() })
        case .tableOfContents, .spread:
            HistoryTopBar(leadingStyle: .home, onLeading: onDismiss)
        }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.phase {
        case .cover:
            BookCover()
        case .tableOfContents:
            BookSpreadContainer(
                showsNextChevron: true,
                onNext: { viewModel.advanceFromTableOfContents() }
            ) {
                JourneyBookIcon()
            } right: {
                TableOfContentsList(
                    rows: viewModel.journeys.enumerated().map { index, journey in
                        TableOfContentsRow(
                            id: journey.historyID,
                            title: viewModel.title(for: journey),
                            date: journey.historyDate,
                            isBookmarked: index == viewModel.journeys.count - 1
                        )
                    },
                    onSelectRow: { row in
                        viewModel.selectRow(id: row.id)
                    }
                )
            }

        case .spread:
            spreadView

        case .detail:
            if let journey = viewModel.selectedJourney {
                detailView(for: journey)
            }
        }
    }

    @ViewBuilder
    private var spreadView: some View {
        if viewModel.journeys.isEmpty {
            BookSpreadContainer {
                EmptyJourneyIllustration()
            } right: {
                PlaceholderJourneyCard(isMostRecent: true, onStartNewJourney: { onDismiss() })
            }
        } else {
            let pair = viewModel.currentPair
            let leftSlot = pair.first
            let rightSlot = pair.count > 1 ? pair[1] : nil

            BookSpreadContainer(
                leftPageNumber: leftSlot.flatMap(viewModel.pageNumber),
                rightPageNumber: rightSlot.flatMap(viewModel.pageNumber),
                showsPreviousChevron: true,
                showsNextChevron: viewModel.canGoToNextPair,
                onPrevious: { viewModel.goToPreviousPair() },
                onNext: { viewModel.goToNextPair() }
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
    private func slotView(_ slot: HistoryViewModel.PageSlot?, ribbonEdge: HorizontalEdge) -> some View {
        switch slot {
        case .journey(let journey):
            JourneyCard(
                title: viewModel.title(for: journey),
                date: journey.historyDate,
                iconName1: journey.subjectPrompt.image,
                iconName2: journey.verbPrompt.image,
                isMostRecent: viewModel.isMostRecent(journey),
                ribbonEdge: ribbonEdge,
                onViewDetails: {
                    viewModel.viewDetails(for: journey)
                }
            )
        case .placeholder:
            PlaceholderJourneyCard(
                isMostRecent: true,
                ribbonEdge: ribbonEdge,
                onStartNewJourney: {
                    onDismiss()
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
                title: viewModel.title(for: journey),
                date: journey.historyDate,
                duration: "1h 3s",
                iconName1: journey.subjectPrompt.image,
                iconName2: journey.verbPrompt.image,
                isMostRecent: viewModel.isMostRecent(journey)
            )
        } right: {
            JourneyMediaContent(
                imageName: journey.thumbnailName,
                isVideo: journey.videoName != nil,
                note: viewModel.note(for: journey),
                onPlay: {
                    // TODO: play back the captured video.
                },
                onAddOrEditNotes: {
                    viewModel.startEditingNotes()
                }
            )
        }
    }
}

#Preview(traits: .landscapeLeft) {
    HistoryView()
        .modelContainer(for: HistoryData.self, inMemory: true)
}

//dummy
//#Preview(traits: .landscapeLeft) {
//    HistoryView(initialJourneys: HistorySampleData.journeys)
//}

//#Preview("Empty state", traits: .landscapeLeft) {
//    HistoryView(initialJourneys: [])
//}
