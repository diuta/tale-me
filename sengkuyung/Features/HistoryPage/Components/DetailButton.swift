//
//  DetailButton.swift
//  sengkuyung
//
//  Created by Catherine Danielle on 08/07/26.
//

import SwiftUI

struct DetailButton: View {
    
    let action: String
    
    var body: some View {
        Rectangle()
            .fill(Color("LightText"))
            .frame(width: 200, height: 50)
            .cornerRadius(1000)
            .overlay(
                Text(action)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
            )
    }
}

#Preview(traits: .landscapeLeft) {
    DetailButton(action: "View Detail")
}
