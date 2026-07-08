//
//  CardPair.swift
//  sengkuyung
//
//  Created by Catherine Danielle on 07/07/26.
//

import SwiftUI

struct CardPair: View {
    
    var body: some View {
        ZStack{
            Circle()
                .strokeBorder(Color.black, style: StrokeStyle(lineWidth: 1, dash: [12,10]))
                .frame(width: 300, height: 300)
            HStack(spacing: 20) {
                IconCard(iconName: "🎣")
                    .rotationEffect(.degrees(-6))
                    .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
                
                Image(systemName: "plus")
                    .font(.system(size: 41, weight: .bold, design: .rounded))
                    .foregroundColor(.black)
                IconCard(iconName: "🐟")
                    .rotationEffect(.degrees(6))
                    .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
            }
        }
        .frame(minHeight: 400)
    }
}

#Preview(traits: .landscapeLeft) {
    CardPair()
}
