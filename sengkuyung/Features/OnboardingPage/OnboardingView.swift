//
//  OnboardingView.swift
//  sengkuyung
//
//  Created by Catherine Danielle on 06/07/26.
//

import SwiftUI

struct OnboardingView: View {
    @State private var currentPage = 0
    @AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding: Bool = false

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            VStack(spacing: 0) {
                TabView(selection: $currentPage) {
                    ForEach(Array(onboardingPages.enumerated()), id: \.element.id) { index, page in
                        OnboardingPageView(page: page)
                            .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .animation(.easeInOut, value: currentPage)

                HStack(spacing: 6) {
                    ForEach(onboardingPages.indices, id: \.self) { index in
                        Capsule()
                            .fill(index == currentPage ? Color(red: 0.93, green: 0.45, blue: 0.4) : Color.gray.opacity(0.3))
                            .frame(width: index == currentPage ? 18 : 6, height: 6)
                            .animation(.easeInOut, value: currentPage)
                    }
                }
                .padding(.top, 8)

                if let buttonTitle = onboardingPages[currentPage].buttonTittle {
                    Button{
                        hasCompletedOnboarding = true
                    } label: {
                        HStack(spacing: 6) {
                            Text(buttonTitle)
                                .fontWeight(.semibold)
                            Image(systemName: "arrow.right")
                        }
                        .foregroundColor(.white)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 28)
                        .background(Color("red: 0.31, green: 0.73, blue: 0.68"))
                        .clipShape(Capsule())
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 24)
                    .transition(.opacity)
                } else {
                    Spacer().frame(height: 44)
                }
            }
        }
    }
}

struct OnboardingPageView: View {
    let page: OnboardingModel

    var body: some View {
        VStack {
            if page.subtitle.isEmpty {
                Spacer()
                Image(page.image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 220)
                Text(page.title)
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(Color("Light Text"))
                    .padding(.top, 12)
                Spacer()
            } else {
                HStack(alignment: .center, spacing: 16) {
                    Image(page.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 130)

                    VStack(alignment: .leading, spacing: 10) {
                        Text(page.title)
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(Color("Light Text"))
                            .fixedSize(horizontal: false, vertical: true)

                        Text(page.subtitle)
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                .padding(.horizontal, 24)
            }
        }
        .padding(.vertical, 32)
    }
}

#Preview {
    OnboardingView()
}
