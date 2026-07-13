//
//  JourneyBookIcon.swift
//  sengkuyung
//
//  Created by Catherine Danielle on 09/07/26.
//

import SwiftUI

struct JourneyBookIcon: View {
    var body: some View {
        ZStack(alignment: .center) {
            Circle()
                .fill(Color("cover"))
                .frame(width: 350, height: 350)
            VStack(spacing: 24){
                Image(systemName: "book.fill")
                    .font(.system(size: 44))
                    .foregroundColor(Color("LightText"))
                
                Text("Tale Me!")
                    .font(.system(size: 48, weight: .bold))
                    .foregroundColor(Color("LightText"))
            }
        }
    }
}

#Preview {
    JourneyBookIcon()
        .padding()
}
