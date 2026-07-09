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
                }

                Spacer()

                if showsTrailingMenu {
                    Button(action: onTrailingMenu) {
                        Image(systemName: "line.3.horizontal")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.primary)
                    }
                } else {
                    Color.clear.frame(width: 20, height: 20)
                }
            }
        }
        .padding(.horizontal, 20)
        .frame(height: 44)
    }
}

#Preview {
    VStack(spacing: 24) {
        HistoryTopBar(leadingStyle: .home)
    }
}
