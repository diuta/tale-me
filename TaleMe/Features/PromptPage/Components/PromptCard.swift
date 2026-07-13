//
//  PromptCard.swift
//  sengkuyung
//
//  Created by Dimas Putra Aryawan on 03/07/26.
//

import SwiftUI

struct PromptCard: View {
    let cardTitle: String
    let promptImage: String
    let promptName: String
    
    var action: () -> Void
    
    var body: some View {
        Button{
            action()
        } label: {
            VStack (spacing: 16){
                Text(cardTitle)
                    .font(Font.title3.bold())
                
                Image(promptImage)
                    .frame(width: 300, height: 300)
                
                Text(promptName)
                    .font(Font.title3.bold())
            }
            .padding(16)
            .contentShape(Rectangle())
        }
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(.ultraThinMaterial)
        )
        .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
        .buttonStyle(.plain)
    }
}

#Preview {
    PromptCard(cardTitle: "Subject", promptImage: "Panda", promptName: "Panda"){}
}
