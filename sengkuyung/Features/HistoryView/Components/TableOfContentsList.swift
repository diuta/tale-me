//
//  TableOfContentsList.swift
//  sengkuyung
//
//  Created by Catherine Danielle on 09/07/26.
//

import SwiftUI

struct TableOfContentsRow: Identifiable {
    let id: UUID
    let title: String
    let date: Date
    var isBookmarked: Bool = false
}

struct TableOfContentsList: View {

    let rows: [TableOfContentsRow]
    var onSelectRow: (TableOfContentsRow) -> Void = { _ in }

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy"
        return formatter
    }()

    var body: some View {
        VStack(alignment: .center, spacing: 14) {
            Text("Your Journey")
            
                .foregroundColor(Color(red: 0.0, green: 129.0 / 255.0, blue: 167.0 / 255.0))
                .font(.system(size: 41, weight: .bold))

            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    ForEach(rows) { row in
                        Button(action: { onSelectRow(row) }) {
                            HStack {
                                Text(row.title)
                                    .font(.system(size: 13, weight: row.isBookmarked ? .bold : .regular))
                                    .foregroundColor(.primary)

                                Spacer()

                                Text(Self.dateFormatter.string(from: row.date))
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(Color(red: 0.0, green: 129.0 / 255.0, blue: 167.0 / 255.0))

                            }
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
        .frame(width: 400, height: 500)
    }
}

#Preview(traits: .landscapeLeft) {
    BookPage {
        TableOfContentsList(rows: [
            .init(id: UUID(), title: "Fishing Elephant", date: Date()),
            .init(id: UUID(), title: "Painting Elephant", date: Date()),
            .init(id: UUID(), title: "Showering Tiger", date: Date()),
            .init(id: UUID(), title: "Running Athlete", date: Date()),
            .init(id: UUID(), title: "Eating Uncle", date: Date()),
            .init(id: UUID(), title: "Studying Astronaut", date: Date()),
            .init(id: UUID(), title: "Sleeping Superhero", date: Date()),
            .init(id: UUID(), title: "Playing Alien", date: Date(), isBookmarked: true),
        ])
        .padding()
    }
    .frame(width: 473, height: 650)
    .padding()
    .background(Color(red: 112.0/255.0, green: 66.0/255.0, blue: 20.0/255.0))
    .cornerRadius(48)
}
