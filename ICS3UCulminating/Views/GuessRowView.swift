//
//  GuessRowView.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 2026-06-01.
//

import SwiftUI

/// A view representing a single row of 5 letters in the Wordle grid.
struct GuessRowView: View {
    
    // MARK: - Stored properties
    let guess: Guess
    
    // MARK: - Computed properties
    var body: some View {
        HStack(spacing: 8) {
            // We show 5 tiles for each guess
            ForEach(0..<5) { index in
                LetterTileView(
                    letter: getLetter(at: index),
                    evaluation: guess.evaluations[index]
                )
            }
        }
    }
    
    // MARK: - Functions
    
    /// Helper to get the letter at a specific position in the word string.
    private func getLetter(at index: Int) -> String {
        let characters = Array(guess.word)
        if index < characters.count {
            return String(characters[index]).uppercased()
        }
        return ""
    }
}

#Preview {
    GuessRowView(guess: Guess(word: "HELLO", evaluations: [.correct, .misplaced, .wrong, .wrong, .correct]))
}
