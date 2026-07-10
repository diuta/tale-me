//
//  HistorySampleData.swift
//  sengkuyung
//
//  Created by Catherine Danielle on 09/07/26.

import Foundation

enum HistorySampleData {

    static let journeys: [HistoryData] = [
        .init(
            subject: SubjectPrompt(id: UUID(), name: "Elephant", image: "🐘"),
            verb: VerbPrompt(id: UUID(), name: "Fishing", image: "🎣", imageBackground: ""),
            date: .init(timeIntervalSinceNow: -86_400 * 6),
            thumbnailName: "sample_journey"
        ),
        .init(
            subject: SubjectPrompt(id: UUID(), name: "Elephant", image: "🐘"),
            verb: VerbPrompt(id: UUID(), name: "Painting", image: "🎨", imageBackground: ""),
            date: .init(timeIntervalSinceNow: -86_400 * 5),
            thumbnailName: "sample_journey"
        ),
        .init(
            subject: SubjectPrompt(id: UUID(), name: "Tiger", image: "🐅"),
            verb: VerbPrompt(id: UUID(), name: "Showering", image: "🚿", imageBackground: ""),
            date: .init(timeIntervalSinceNow: -86_400 * 4),
            thumbnailName: "sample_journey"
        ),
        .init(
            subject: SubjectPrompt(id: UUID(), name: "Athlete", image: "🏅"),
            verb: VerbPrompt(id: UUID(), name: "Running", image: "🏃", imageBackground: ""),
            date: .init(timeIntervalSinceNow: -86_400 * 3),
            thumbnailName: "sample_journey"
        ),
        .init(
            subject: SubjectPrompt(id: UUID(), name: "Uncle", image: "👨"),
            verb: VerbPrompt(id: UUID(), name: "Eating", image: "🍽️", imageBackground: ""),
            date: .init(timeIntervalSinceNow: -86_400 * 2),
            thumbnailName: "sample_journey"
        ),
        .init(
            subject: SubjectPrompt(id: UUID(), name: "Astronaut", image: "🧑‍🚀"),
            verb: VerbPrompt(id: UUID(), name: "Studying", image: "📚", imageBackground: ""),
            date: .init(timeIntervalSinceNow: -86_400),
            thumbnailName: "sample_journey"
        ),
        .init(
            subject: SubjectPrompt(id: UUID(), name: "Superhero", image: "🦸"),
            verb: VerbPrompt(id: UUID(), name: "Sleeping", image: "😴", imageBackground: ""),
            date: .init(),
            thumbnailName: "sample_journey"
        ),
    ]

    static let empty: [HistoryData] = []
}
