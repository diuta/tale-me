//
//  HistorySampleData.swift
//  sengkuyung
//
//  Created by Catherine Danielle on 09/07/26.

import Foundation

enum HistorySampleData {

    static let journeys: [HistoryModel] = [
        .init(id: UUID(), title: "Fishing Elephant", date: .init(timeIntervalSinceNow: -86_400 * 6), subject: "🎧", verb: "🐘", image: "sample_journey", audio: "", note: "Today, Abdul learned that elephants are big and very creative. He also learned that elephants are gentle."),
        .init(id: UUID(), title: "Painting Elephant", date: .init(timeIntervalSinceNow: -86_400 * 5), subject: "🎨", verb: "🐘", image: "sample_journey", audio: "", note: ""),
        .init(id: UUID(), title: "Showering Tiger", date: .init(timeIntervalSinceNow: -86_400 * 4), subject: "🚿", verb: "🐅", image: "sample_journey", audio: "", note: ""),
        .init(id: UUID(), title: "Running Athlete", date: .init(timeIntervalSinceNow: -86_400 * 3), subject: "🏃", verb: "🏅", image: "sample_journey", audio: "", note: ""),
        .init(id: UUID(), title: "Eating Uncle", date: .init(timeIntervalSinceNow: -86_400 * 2), subject: "🍽️", verb: "👨", image: "sample_journey", audio: "", note: ""),
        .init(id: UUID(), title: "Studying Astronaut", date: .init(timeIntervalSinceNow: -86_400), subject: "📚", verb: "🧑‍🚀", image: "sample_journey", audio: "", note: ""),
        .init(id: UUID(), title: "Sleeping Superhero", date: .init(), subject: "😴", verb: "🦸", image: "sample_journey", audio: "", note: ""),
    ]

    static let empty: [HistoryModel] = []
}
