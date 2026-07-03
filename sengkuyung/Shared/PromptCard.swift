//
//  PromptCard.swift
//  sengkuyung
//
//  Created by Dimas Putra Aryawan on 03/07/26.
//

import SwiftUI

struct PromptCard: View {
    var cardTitle: String
    var promptImage: String
    var promptName: String
    
    var body: some View {
        Button(
            action: {}
        ){
            VStack{
                Text(cardTitle)
                    .font(Font.title3.bold())
                Image(promptImage)
                    .frame(width: 300, height: 300)
                Text(promptName)
                    .font(Font.title3.bold())
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(.ultraThinMaterial)
                    .frame(width: 343, height: 450)
            )
            .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
            .padding(.horizontal)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    PromptCard(cardTitle: "Subject", promptImage: "Panda", promptName: "Panda")
}
