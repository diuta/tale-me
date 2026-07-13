//
//  HistoryView.swift
//  sengkuyung
//
//  Created by Catherine Danielle on 09/07/26.
//


import SwiftUI
import SwiftData
import AVKit
import UIKit

struct HistoryView: View {
    
    var onDismiss: () -> Void = {}
    
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel: HistoryViewModel
    @State private var isPlayingVideo = false
    @State private var player: AVPlayer?
    private let storageService = StorageService()
    
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
        .alert(
            "Delete this story?",
            isPresented: Binding(
                get: { viewModel.journeyPendingDeletion != nil },
                set: { isPresented in
                    if !isPresented { viewModel.cancelDelete() }
                }
            ),
            presenting: viewModel.journeyPendingDeletion
        ) { _ in
            Button("Cancel", role: .cancel) { viewModel.cancelDelete() }
            Button("Delete", role: .destructive) {
                viewModel.confirmDelete(context: modelContext, storageService: storageService)
            }
        } message: { journey in
            Text("\"\(viewModel.title(for: journey))\" and its video will be permanently deleted. This can't be undone.")
        }
        .navigationBarBackButtonHidden()
        .fullScreenCover(isPresented: $isPlayingVideo, onDismiss: {
            player?.pause()
            player = nil

//            DispatchQueue.main.async {
//                UIApplication.shared.connectedScenes
//                    .compactMap { $0 as? UIWindowScene }
//                    .flatMap { $0.windows }
//                    .forEach { $0.isUserInteractionEnabled = true }
//            }
        }) {
            if let player {
                ZStack(alignment: .topLeading) {
                    VideoPlayerView(player: player)
                        .ignoresSafeArea()
                        .onAppear { player.play() }
//                    Button {
//                        isPlayingVideo = false
//                    } label: {
//                        Image(systemName: "chevron.left")
//                            .font(.system(size: 17, weight: .semibold))
//                            .foregroundColor(.white)
//                            .frame(width: 36, height: 36)
//                            .glassBackground()
//                    }
//                    .buttonStyle(.plain)
//                    .padding(.top, 20)
//                    .padding(.leading, 20)
                }
            }
        }
    }
    
    @ViewBuilder
    private var topBar: some View {
        switch viewModel.phase {
        case .cover:
            HistoryTopBar(leadingStyle: .home, showsTrailingMenu: false, onLeading: onDismiss)
        case .detail:
            HistoryTopBar(
                leadingStyle: .back,
                onLeading: { viewModel.backToSpreadFromDetail() },
                onTrailingMenu: { viewModel.showTableOfContents() }
            )
        case .spread:
            HistoryTopBar(
                leadingStyle: .home,
                onLeading: onDismiss,
                onTrailingMenu: { viewModel.showTableOfContents() }
            )
        case .tableOfContents:
            HistoryTopBar(leadingStyle: .home, showsTrailingMenu: false, onLeading: onDismiss)
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
                thumbnailURL: journey.thumbnailURL,
                isVideo: true,
                note: viewModel.note(for: journey),
                onPlay: {
                    player = AVPlayer(url: journey.videoURL)
                    isPlayingVideo = true
                },
                onAddOrEditNotes: {
                    viewModel.startEditingNotes()
                }
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(alignment: .topTrailing) {
                Button {
                    viewModel.requestDelete(journey)
                } label: {
                    Image(systemName: "trash")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(Color("LightText"))
                        .frame(width: 32, height: 32)
                        .glassBackground()
                }
                .buttonStyle(.plain)
                .padding(.top, 12)
                .padding(.trailing, 8)
            }
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
