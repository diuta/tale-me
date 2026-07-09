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
                .fill(Color(red: 226.0 / 255.0, green: 217.0 / 255.0, blue: 208.0 / 255.0))
                .frame(width: 350, height: 350)
            VStack(spacing: 24){
                Image(systemName: "book.fill")
                    .font(.system(size: 44))
                    .foregroundColor(Color(red: 0.0, green: 175.0 / 255.0, blue: 185.0 / 255.0))
                
                Text("Tale Me!")
                    .font(.system(size: 48, weight: .bold))
                    .foregroundColor(Color(red: 0.0, green: 175.0 / 255.0, blue: 185.0 / 255.0))
            }
        }
    }
}

#Preview {
    JourneyBookIcon()
        .padding()
}
