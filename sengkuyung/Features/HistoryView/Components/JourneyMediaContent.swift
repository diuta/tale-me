//
//  JourneyMediaContent.swift
//  sengkuyung
//
//  Created by Catherine Danielle on 09/07/26.
//

import SwiftUI

struct JourneyMediaContent: View {

    var imageName: String? = nil
    var isVideo: Bool = false
    var note: String = ""
    var onPlay: () -> Void = {}
    var onAddOrEditNotes: () -> Void = {}

    private let accent = Color(red: 0.0, green: 129.0 / 255.0, blue: 167.0 / 255.0)

    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(.systemGray5))
                    .overlay {
                        if let imageName {
                            Image(imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                        } else {
                            Image(systemName: "photo")
                                .font(.system(size: 32))
                                .foregroundColor(.secondary)
                        }
                    }
                    .clipped()
                    .frame(width: 350, height: 265)

                if isVideo {
                    Button(action: onPlay) {
                        ZStack {
                            Circle()
                                .fill(Color.white.opacity(0.85))
                                .frame(width: 48, height: 48)
                            Image(systemName: "play.fill")
                                .font(.system(size: 18))
                                .foregroundColor(.black)
                                .offset(x: 2)
                        }
                        .shadow(color: .black.opacity(0.2), radius: 6, x: 0, y: 2)
                    }
                    .buttonStyle(.plain)
                }
            }

            notesArea
        }
    }

    @ViewBuilder
    private var notesArea: some View {
        if note.isEmpty {
            Button(action: onAddOrEditNotes) {
                Label("Add Notes", systemImage: "pencil")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(accent)
            }
            .buttonStyle(.plain)
        } else {
            VStack(alignment: .leading, spacing: 6) {
                Text(note)
                    .font(.system(size: 12))
                    .foregroundColor(.primary)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(width: 350, alignment: .leading)

                Button(action: onAddOrEditNotes) {
                    Label("Edit Notes", systemImage: "pencil")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(accent)
                }
                .buttonStyle(.plain)
            }
        }
    }
}

#Preview(traits: .landscapeLeft) {
    HStack(spacing: 40) {
        JourneyMediaContent(isVideo: true)
        JourneyMediaContent(
            isVideo: true,
            note: "Today, Abdul learned that elephants are big and very creative. He also learned that elephants are..."
        )
    }
    .padding()
}
