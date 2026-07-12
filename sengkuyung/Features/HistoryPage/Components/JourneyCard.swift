//
//  JourneyCard.swift
//  sengkuyung
//
//  Created by Catherine Danielle on 09/07/26.
//

import SwiftUI

struct JourneyCard: View {

    let title: String
    let date: Date
    let iconName1: String
    let iconName2: String
    var isMostRecent: Bool = false
    var ribbonEdge: HorizontalEdge = .trailing
    var onViewDetails: () -> Void = {}

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        return formatter
    }()


    private let baseWidth: CGFloat = 440
    private let baseHeight: CGFloat = 600

    var body: some View {
        GeometryReader { geo in
            let scale = min(geo.size.width / baseWidth, geo.size.height / baseHeight)

            ZStack(alignment: ribbonEdge == .trailing ? .topTrailing : .topLeading) {
                VStack(spacing: 40 * scale) {
                    VStack(spacing: 2) {
                        Text(title)
                            .font(.system(size: 18 * scale, weight: .bold))
                            .foregroundColor(Color("LightText"))
                        Text(Self.dateFormatter.string(from: date))
                            .font(.system(size: 12 * scale))
                            .foregroundColor(.secondary)
                    }

                    CardPair(iconName1: iconName1, iconName2: iconName2)
                        .scaleEffect(scale)
                        .frame(height: 250 * scale)

                    Button(action: onViewDetails) {
                        DetailButton(action: "View Details")
                            .scaleEffect(scale)
                    }
                    .buttonStyle(.plain)
                    .frame(height: 40 * scale)
                }
                .frame(width: geo.size.width, height: geo.size.height)

                if isMostRecent {
                    BookRibbon()
                        .scaleEffect(scale)
                        .offset(x: ribbonEdge == .trailing ? -8 * scale : 8 * scale, y: -6 * scale)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview(traits: .landscapeLeft) {
    HStack(spacing: 40) {
        JourneyCard(title: "Fishing Elephant", date: Date(), iconName1: "memancing", iconName2: "gajah", isMostRecent: true)
            .frame(width: 440, height: 600)
        JourneyCard(title: "Swimming Cat", date: Date(), iconName1: "berenang", iconName2: "kucing")
            .frame(width: 440, height: 600)
    }
    .padding()
}
