//
//  BookSpreadContainer.swift
//  sengkuyung
//

import SwiftUI

/// The reusable "open book" shell used across every History screen —
/// Table of Contents, journey card spreads, and the empty/no-session page.
/// It just lays out whatever `left` and `right` content you give it inside
/// the brown frame with a spine divider; it doesn't know about Journeys.
struct BookSpreadContainer<Left: View, Right: View>: View {

    var leftPageNumber: Int? = nil
    var rightPageNumber: Int? = nil
    var showsPreviousChevron: Bool = false
    var showsNextChevron: Bool = false
    var onPrevious: (() -> Void)? = nil
    var onNext: (() -> Void)? = nil

    private let left: Left
    private let right: Right

    private let bookBrown = Color(red: 0.42, green: 0.24, blue: 0.12)
    private let bookBrownDarker = Color(red: 0.33, green: 0.19, blue: 0.095)
    private let pageBackground = Color(red: 0.93, green: 0.93, blue: 0.93)

    init(
        leftPageNumber: Int? = nil,
        rightPageNumber: Int? = nil,
        showsPreviousChevron: Bool = false,
        showsNextChevron: Bool = false,
        onPrevious: (() -> Void)? = nil,
        onNext: (() -> Void)? = nil,
        @ViewBuilder left: () -> Left,
        @ViewBuilder right: () -> Right
    ) {
        self.leftPageNumber = leftPageNumber
        self.rightPageNumber = rightPageNumber
        self.showsPreviousChevron = showsPreviousChevron
        self.showsNextChevron = showsNextChevron
        self.onPrevious = onPrevious
        self.onNext = onNext
        self.left = left()
        self.right = right()
    }

    /// The size the book's internal layout (page rectangle, spine, page
    /// number row) was hand-tuned at. We build the book at this fixed
    /// "design" size, then scale the whole thing up or down with
    /// `GeometryReader` so it actually fills whatever space the parent
    /// gives it instead of staying pinned at 970×640 on every screen.
    private let designWidth: CGFloat = 480 * 2 + 10
    private let designHeight: CGFloat = 640

    var body: some View {
        HStack(spacing: 8) {
            chevronButton(systemName: "chevron.left", isVisible: showsPreviousChevron, action: onPrevious)

            GeometryReader { outerGeo in
                let scale = min(outerGeo.size.width / designWidth, outerGeo.size.height / designHeight)

                book
                    .frame(width: designWidth, height: designHeight)
                    .scaleEffect(scale)
                    .frame(width: outerGeo.size.width, height: outerGeo.size.height)
            }
            .aspectRatio(designWidth / designHeight, contentMode: .fit)

            chevronButton(systemName: "chevron.right", isVisible: showsNextChevron, action: onNext)
        }
        .padding(.horizontal, 20)
    }

    @ViewBuilder
    private var book: some View {
        ZStack(alignment: .bottom) {
            RoundedRectangle(cornerRadius: 32, style: .continuous)
                .fill(pageBackground)
                .overlay(
                    RoundedRectangle(cornerRadius: 32, style: .continuous)
                        .strokeBorder(bookBrown, lineWidth: 20)

                )
                .shadow(color: .black.opacity(0.18), radius: 14, x: 0, y: 10)
                .frame(width: designWidth, height: designHeight)

            HStack(spacing: 0) {
                left
                    .frame(width: 480, height: 620)

                ZStack {
                    Rectangle()
                        .fill(bookBrown)
                        .frame(width: 24, height: 617)
                    Rectangle()
                        .fill(
                            LinearGradient(colors: [Color.black.opacity(0.12),
                                                    Color.white.opacity(0.1),
                                                    Color.black.opacity(0.12)], startPoint: .leading, endPoint: .trailing)
                        )
                        .frame(width: 10)
                }

                right
                    .frame(width: 480, height: 620)
            }
            .padding(18)

            pageNumberRow
        }
    }

    @ViewBuilder
    private var pageNumberRow: some View {
        HStack {
            if let leftPageNumber {
                Text("\(leftPageNumber)")
                    .font(.subheadline.bold())
                    .padding(.leading, 28)
            }
            Spacer()
            if let rightPageNumber {
                Text("\(rightPageNumber)")
                    .font(.subheadline.bold())
                    .padding(.trailing, 28)
            }
        }
        .padding(.bottom, 32)
        .frame(width: 480*2)
    }

    @ViewBuilder
    private func chevronButton(systemName: String, isVisible: Bool, action: (() -> Void)?) -> some View {
        Button(action: { action?() }) {
            Image(systemName: systemName)
                .font(.title2.bold())
                .foregroundColor(Color(red: 0.0, green: 129.0 / 255.0, blue: 167.0 / 255.0))
        }
        .frame(width: 32, height: 44)
        .opacity(isVisible ? 1 : 0)
        .disabled(!isVisible)
    }
}

#Preview(traits: .landscapeLeft) {
    BookSpreadContainer(
        leftPageNumber: 1,
        rightPageNumber: 2,
        showsPreviousChevron: true,
        showsNextChevron: true
    ) {
        CardPair(iconName1: "🥽", iconName2: "🐅")
    } right: {
        CardPair(iconName1: "🛍️", iconName2: "🐘")
    }
    .padding()
    .background(Color.white)
}
