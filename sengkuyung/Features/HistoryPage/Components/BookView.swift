//
//  BookView.swift
//  sengkuyung
//
//  Created by Catherine Danielle on 08/07/26.
//

import SwiftUI

struct BookView<LeftPage: View, RightPage:View>: View {
    
    let leftPage: LeftPage
    let rightPage: RightPage
    
    init(
        @ViewBuilder leftPage: () -> LeftPage,
        @ViewBuilder rightPage: () -> RightPage
    ) {
        self.leftPage = leftPage()
        self.rightPage = rightPage()
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 48)
                .fill(Color(red: 112.0/255.0, green: 66.0/255.0, blue: 20.0/255.0))
                .frame(width: 1040, height: 650)

            HStack {
                BookPage {
                    leftPage
                }
                Rectangle()
                    .fill(
                        LinearGradient(colors: [Color.black.opacity(0.12),
                                                Color.white.opacity(0.1),
                                                Color.black.opacity(0.12)], startPoint: .leading, endPoint: .trailing)
                    )
                    .frame(width: 10)
                BookPage {
                    rightPage
                }
            }
            .frame(width: 984, height: 620)
        }
    }
}

#Preview(traits: .landscapeLeft) {
    ZStack{
        Color.brown.opacity(0.1)
            .ignoresSafeArea()
        BookView{
            VStack{
                Text("Table of Content")
                    .font(.title)
                Spacer()
            }
        } rightPage: {
            VStack {
                Text("Journey Page")
                    .font(.title)
                Spacer()
            }
        }
    }
}
