//
//  EmptyJourneyIllustration.swift
//  sengkuyung
//
//  Created by Catherine Danielle on 09/07/26.
//

import SwiftUI

struct EmptyJourneyIllustration: View {
    
    
    var body: some View {
        VStack(spacing: 16) {
            ZStack(alignment: .topTrailing) {
                Image("tale_berfikir")
                    .font(.system(size: 90))
                    .foregroundColor(Color(red: 0.42, green: 0.24, blue: 0.12)
                    )
            }
            .frame(height: 110)
            
            Text("Your journey hasn't started yet")
                .padding(.top, 160)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(Color(red: 0.0/255.0, green: 129.0/255.0, blue: 167.0/255.0)
                )
                
            
        }
    }
}

#Preview(traits: .landscapeLeft) {
    EmptyJourneyIllustration()
        .padding()
}
