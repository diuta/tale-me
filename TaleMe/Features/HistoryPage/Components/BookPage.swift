//
//  BookPage.swift
//  sengkuyung
//
//  Created by Catherine Danielle on 08/07/26.
//

import SwiftUI

struct BookPage<Content: View>: View {

    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 32)
                .fill(.white)
                .shadow(
                    color: (Color("pageBackground")).opacity(0.15), radius: 8, x: 0, y: 4
                )

            content
                .padding(28)
        }
    }
}

#Preview {
    BookPage {
    }
    .frame(width: 473, height: 650)
    .padding()
    .background(Color("bookBrown"))
    .cornerRadius(48)
}
