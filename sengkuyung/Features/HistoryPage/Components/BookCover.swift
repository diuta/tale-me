//
//  BookView.swift
//  sengkuyung
//
//  Created by Catherine Danielle on 08/07/26.
//

import SwiftUI

struct BookCover: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 32)
                .fill(Color("bookBrown"))
                .frame(width: 473, height: 650)
                .overlay(alignment: .leading) {
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.18),
                            Color.clear
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    .frame(width: 30)
                }
                .overlay(alignment: .leading) {
                    Rectangle()
                        .fill(Color.black.opacity(0.18))
                        .frame(width: 4)
                        .padding(.leading, 28)
                }
                .overlay(alignment: .trailing) {
                    LinearGradient(
                        colors: [
                            Color.clear,
                            Color.black.opacity(0.12)
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    .frame(width: 24)
                }
                .overlay {
                    RoundedRectangle(cornerRadius: 32)
                        .stroke(Color.white.opacity(0.08), lineWidth: 1)
                }
                .shadow(
                    color: Color.black.opacity(0.15),
                    radius: 10,
                    x: 0,
                    y: 5
                )
            
            Circle()
                .fill(Color("cover"))
                .frame(width: 350, height: 350)
            
            Image("tale_menyapa")
                .padding(.bottom, 80)
                .frame(width: 259, height: 441)
            Text("Tale Me!")
                .padding(.top, 450)
                .font(Font.custom("sfprotext-semibold", size: 41)) //font nya blm fix
                .foregroundColor(Color("cover"))
        }
    }
}

#Preview {
    BookCover()
}
