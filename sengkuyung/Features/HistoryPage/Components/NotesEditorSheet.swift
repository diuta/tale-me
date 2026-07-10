//
//  NotesEditorSheet.swift
//  sengkuyung
//
//  Created by Catherine Danielle on 10/07/26.
//

import SwiftUI

/// The "Write your notes..." card presented whenever the user wants to add
/// or edit the notes attached to a journey.
struct NotesEditorSheet: View {

    var onCancel: () -> Void = {}
    var onConfirm: (String) -> Void = { _ in }

    @State private var text: String
    private let maxWords: Int

    private let accent = Color(red: 0.0, green: 129.0 / 255.0, blue: 167.0 / 255.0)

    init(
        initialText: String = "",
        maxWords: Int = 30,
        onCancel: @escaping () -> Void = {},
        onConfirm: @escaping (String) -> Void = { _ in }
    ) {
        self._text = State(initialValue: initialText)
        self.maxWords = maxWords
        self.onCancel = onCancel
        self.onConfirm = onConfirm
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Write your notes...")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.primary)

            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(.systemGray5))

                if text.isEmpty {
                    Text("Type here... (max \(maxWords) words)")
                        .font(.system(size: 15))
                        .foregroundColor(.secondary)
                        .padding(.horizontal, 16)
                        .padding(.top, 16)
                }

                TextEditor(text: $text)
                    .font(.system(size: 15))
                    .scrollContentBackground(.hidden)
                    .padding(8)
                    .onChange(of: text) { _, newValue in
                        text = limited(newValue)
                    }
            }
            // Adaptive instead of a fixed 358x467 — a hardcoded portrait-sized
            // box like that doesn't fit inside a .medium sheet in landscape,
            // which pushed the title/buttons off-screen and left only this
            // box visible (looking like a blank card).
            .frame(minHeight: 100, maxHeight: 220)
            .frame(maxWidth: .infinity)

            HStack(spacing: 16) {
                Button(action: onCancel) {
                    Text("Cancel")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .background(Color(.systemGray4))
                        .clipShape(Capsule())
                }
                .buttonStyle(.plain)

                Button(action: { onConfirm(text) }) {
                    Text("Confirm")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .background(accent)
                        .clipShape(Capsule())
                }
                .buttonStyle(.plain)
            }
        }
        .padding(20)
        .background(Color(.systemGray6))
        .cornerRadius(28)
    }

    private func limited(_ value: String) -> String {
        let words = value.split(whereSeparator: { $0.isWhitespace || $0.isNewline })
        guard words.count > maxWords else { return value }
        return words.prefix(maxWords).joined(separator: " ")
    }
}

#Preview {
    NotesEditorSheet(initialText: "")
        .padding()
        .background(Color.black.opacity(0.35))
}
