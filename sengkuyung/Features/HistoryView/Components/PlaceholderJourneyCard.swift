//
//  PlaceholderJourneyCard.swift
//  sengkuyung
//
//  Created by Catherine Danielle on 09/07/26.
//

import SwiftUI
struct PlaceholderJourneyCard: View {

    var isMostRecent: Bool = false
    var ribbonEdge: HorizontalEdge = .leading
    var onStartNewJourney: () -> Void = {}

    var body: some View {
        GeometryReader { geo in
            let scale = min(geo.size.width / 440, geo.size.height / 600)

            ZStack(alignment: ribbonEdge == .trailing ? .topTrailing : .topLeading) {
                VStack(spacing: 40 * scale) {
                    Spacer(minLength: 0)

                    CardPair(
                        icon1: .symbol("questionmark", color:(Color(red: 0/255, green: 129/255, blue: 167/255))),
                        icon2: .symbol("questionmark", color: (Color(red: 0/255, green: 129/255, blue: 167/255)))
                    )
                    .scaleEffect(scale)
                    .frame(height: 250 * scale)

                    Button(action: onStartNewJourney) {
                        DetailButton(action: "Start New Journey")
                            .scaleEffect(scale)
                    }
                    .buttonStyle(.plain)
                    .frame(height: 40 * scale)

                    Spacer(minLength: 0)
                }
                .frame(width: geo.size.width, height: geo.size.height)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview(traits: .landscapeLeft) {
    PlaceholderJourneyCard(isMostRecent: true)
        .padding()
}
