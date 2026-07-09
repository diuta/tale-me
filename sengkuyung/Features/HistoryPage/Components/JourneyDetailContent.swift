//
//  JourneyDetailContent.swift
//  sengkuyung
//
//  Created by Catherine Danielle on 09/07/26.
//

import SwiftUI

struct JourneyDetailContent: View {

    let title: String
    let date: Date
    let duration: String
    let iconName1: String
    let iconName2: String
    var isMostRecent: Bool = false

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        return formatter
    }()

    private let accent = Color(red: 0.0, green: 129.0 / 255.0, blue: 167.0 / 255.0)

    private let baseWidth: CGFloat = 440
    private let baseHeight: CGFloat = 600

    var body: some View {
        GeometryReader { geo in
            let scale = min(geo.size.width / baseWidth, geo.size.height / baseHeight)

            ZStack(alignment: .topTrailing) {
                VStack(alignment: .leading, spacing: 12 * scale) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(title)
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(accent)

                        HStack(spacing: 10) {
                            Label(Self.dateFormatter.string(from: date), systemImage: "calendar")
                            Label(duration, systemImage: "clock")
                        }
                        .font(.system(size: 11))
                        .foregroundColor(.secondary)
                    }

                    CardPair(iconName1: iconName1, iconName2: iconName2)
                        .scaleEffect(scale)
                        .frame(height: 250 * scale)
                }
                .frame(width: geo.size.width, alignment: .topLeading)

                if isMostRecent {
                    BookRibbon()
                        .scaleEffect(scale)
                        .offset(x: -8 * scale, y: -6 * scale)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview(traits: .landscapeLeft) {
    HStack(spacing: 40) {
        JourneyDetailContent(
            title: "Fishing Elephant",
            date: Date(),
            duration: "1h 3s",
            iconName1: "🎧",
            iconName2: "🐼",
            isMostRecent: true
        )
        JourneyDetailContent(
            title: "Fishing Elephant",
            date: Date(),
            duration: "1h 3s",
            iconName1: "🎧",
            iconName2: "🐼"
        )
    }
    .padding()
}
