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

    private let designWidth: CGFloat = 480 * 2 + 24 + 18 * 2
    private let designHeight: CGFloat = 620 + 18 * 2

    var body: some View {
        HStack(spacing: 8) {
            chevronButton(systemName: "chevron.left", isVisible: showsPreviousChevron, action: onPrevious)

            GeometryReader { outerGeo in
                let rawScale = min(outerGeo.size.width / designWidth, outerGeo.size.height / designHeight)
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
                .fill(Color("pageBackground"))
                .overlay(
                    RoundedRectangle(cornerRadius: 32, style: .continuous)
                        .strokeBorder(Color("bookBrown"), lineWidth: 20)

                )
                .shadow(color: .black.opacity(0.18), radius: 14, x: 0, y: 10)
                .frame(width: designWidth, height: designHeight)

            HStack(spacing: 0) {
                left
                    .frame(width: 480, height: 620)

                ZStack {
                    Rectangle()
                        .fill(Color("bookBrown"))
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
                .foregroundColor(Color("LightText"))
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
        CardPair(iconName1: "berenang", iconName2: "kucing")
    } right: {
        CardPair(iconName1: "berpetualang", iconName2: "gajah")
    }
    .padding()
    .background(Color.white)
}
