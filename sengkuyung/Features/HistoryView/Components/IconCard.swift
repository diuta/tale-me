//
//  PromptCard.swift
//  sengkuyung
//
//  Created by Catherine Danielle on 07/07/26.
//

import SwiftUI

struct IconCard: View {
    
    let iconName: String
    
    var body: some View {
        Text(iconName)
            .font(.system(size: 41))
            .background(RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .frame(width: 120, height: 120)
                .shadow(radius: 10))
    }
}

#Preview(traits: .landscapeLeft) {
    IconCard(
        iconName: "🌊"
    )
}
