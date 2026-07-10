//
//  BookSpreadContainer.swift
//  sengkuyung
//

import SwiftUI

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

    // Must match the book's actual content: two 480pt pages + the 24pt spine,
    // plus the 18pt padding applied on every edge inside `book`. The previous
    // constants (970x640) were smaller than that real content size, so the
    // page background/frame never matched what was actually being laid out —
    // `book` silently rendered larger than designWidth/designHeight, which
    // threw off the scale-to-fit math in `body` and could blow the page up
    // far past the visible area.
    private let designWidth: CGFloat = 480 * 2 + 24 + 18 * 2
    private let designHeight: CGFloat = 620 + 18 * 2

    var body: some View {
        HStack(spacing: 8) {
            chevronButton(systemName: "chevron.left", isVisible: showsPreviousChevron, action: onPrevious)

            GeometryReader { outerGeo in
                let rawScale = min(outerGeo.size.width / designWidth, outerGeo.size.height / designHeight)
                // Never let the book scale up past its design size — on a window/device
                // larger than the 970x640 design canvas this would blow the content up
                // far beyond the visible frame, leaving only a cropped, blank-looking
                // sliver on screen.
                let scale = rawScale.isFinite ? min(rawScale, 1) : 1

                book
                    .frame(width: designWidth, height: designHeight)
                    .scaleEffect(scale)
                    .frame(width: outerGeo.size.width, height: outerGeo.size.height)
                    .clipped()
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
        .frame(width: designWidth)
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
