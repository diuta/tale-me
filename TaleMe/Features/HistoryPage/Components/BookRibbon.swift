//
//  BookRibbon.swift
//  sengkuyung
//
//  Created by Catherine Danielle on 08/07/26.
//

import SwiftUI

struct BookRibbon: View {
    var body: some View {
        RibbonShape()
            .fill(Color(red: 239.0/255.0, green: 68.0/255.0, blue: 68.0/255.0))
            .frame(width: 45, height: 128)
            .shadow(color:. black.opacity(0.15), radius: 3, x: 1, y: 2)
    }
}

private struct RibbonShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let notch = rect.width / 2
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY - notch))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

#Preview {
    BookRibbon()
}
