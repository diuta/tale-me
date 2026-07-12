//
//  HistoryTopBar.swift
//  sengkuyung
//
//  Created by Catherine Danielle on 09/07/26.
//

import SwiftUI

struct HistoryTopBar: View {

    enum LeadingStyle {
        case home
        case back
    }

    var leadingStyle: LeadingStyle = .home
    var showsTrailingMenu: Bool = true
    var onLeading: () -> Void = {}
    var onTrailingMenu: () -> Void = {}

    var body: some View {
        ZStack {
            Text("History")
                .font(.system(size: 17, weight: .semibold))

            HStack {
                Button(action: onLeading) {
                    Image(systemName: leadingStyle == .home ? "house.fill" : "chevron.left")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.primary)
                        .frame(width: 36, height: 36)
                        .glassBackground()
                }
                .buttonStyle(.plain)

                Spacer()

                if showsTrailingMenu {
                    Button(action: onTrailingMenu) {
                        Image(systemName: "line.3.horizontal")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.primary)
                            .frame(width: 36, height: 36)
                            .glassBackground()
                    }
                    .buttonStyle(.plain)
                } else {
                    Color.clear.frame(width: 36, height: 36)
                }
            }
        }
        .padding(.horizontal, 20)
        .frame(height: 44)
    }
}

extension View {
    func glassBackground() -> some View {
        self
            .background(
                Circle()
                    .fill(.ultraThinMaterial)
                    .overlay(
                        Circle().stroke(Color.white.opacity(0.35), lineWidth: 1)
                    )
            )
            .shadow(color: .black.opacity(0.12), radius: 6, x: 0, y: 3)
    }
}

#Preview {
    VStack(spacing: 24) {
        HistoryTopBar(leadingStyle: .home)
        HistoryTopBar(leadingStyle: .back)
    }
    .padding()
    .background(Color.gray.opacity(0.2))
}
