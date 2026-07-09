//
//  CardPair.swift
//  sengkuyung
//
//  Created by Catherine Danielle on 07/07/26.
//

import SwiftUI

struct CardPair: View {

    /// A single slot's content — either an emoji/text glyph, or an SF Symbol
    /// that can be tinted to any color.
    enum Icon {
        case emoji(String)
        case symbol(String, color: Color = Color(red: 0.0, green: 129.0/255.0, blue: 167.0/255.0))
    }

    let iconName1: String
    let iconName2: String
    var icon1Style: Icon? = nil
    var icon2Style: Icon? = nil

    private static let accent = Color(red: 0.0, green: 129.0/255.0, blue: 167.0/255.0)

    init(iconName1: String, iconName2: String) {
        self.iconName1 = iconName1
        self.iconName2 = iconName2
    }

    init(icon1: Icon, icon2: Icon) {
        self.iconName1 = ""
        self.iconName2 = ""
        self.icon1Style = icon1
        self.icon2Style = icon2
    }

    var body: some View {
        ZStack{
            Circle()
                .strokeBorder(Self.accent, style: StrokeStyle(lineWidth: 3, dash: [12,10]))
                .frame(width: 300, height: 300)
            HStack(spacing: 72) {
                iconView(icon1Style ?? .emoji(iconName1))
                    .rotationEffect(.degrees(-6))

                Image(systemName: "plus")
                    .font(.system(size: 41, weight: .bold, design: .rounded))
                    .foregroundColor(Self.accent)

                iconView(icon2Style ?? .emoji(iconName2))
                    .rotationEffect(.degrees(6))
            }
        }
        .frame(minHeight: 400)
    }

    @ViewBuilder
    private func iconView(_ icon: Icon) -> some View {
        Group {
            switch icon {
            case .emoji(let value):
                Text(value)
                    .font(.system(size: 41))
            case .symbol(let name, let color):
                Image(systemName: name)
                    .font(.system(size: 41, weight: .semibold))
                    .foregroundColor(color)
            }
        }
        .background(RoundedRectangle(cornerRadius: 16)
            .fill(Color.white)
            .frame(width: 120, height: 120)
            .shadow(radius: 10))
        .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
    }
}

#Preview(traits: .landscapeLeft) {
    HStack(spacing: 40) {
        CardPair(iconName1: "🌊", iconName2: "🐼")
        CardPair(
            icon1: .symbol("questionmark", color: Color(red: 0/255, green: 129/255, blue: 167/255)),
            icon2: .symbol("questionmark", color: Color(red: 0/255, green: 129/255, blue: 167/255))
        )
    }
    .padding()
}
