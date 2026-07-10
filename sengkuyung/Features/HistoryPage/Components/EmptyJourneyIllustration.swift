//
//  EmptyJourneyIllustration.swift
//  sengkuyung
//
//  Created by Catherine Danielle on 09/07/26.
//

import SwiftUI

struct EmptyJourneyIllustration: View {
    
    
    var body: some View {
        VStack(spacing: 24) {
            Image("tale_berfikir")
                .resizable()
                .scaledToFit()
                .frame(width: 483, height: 444)

            Text("Your journey hasn't started yet")
                .font(.system(size: 24, weight: .bold))
                .multilineTextAlignment(.center)
                .foregroundColor(Color(red: 0.0/255.0, green: 129.0/255.0, blue: 167.0/255.0))
                .frame(width: 285, height: 92)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview(traits: .landscapeLeft) {
    EmptyJourneyIllustration()
    
}
