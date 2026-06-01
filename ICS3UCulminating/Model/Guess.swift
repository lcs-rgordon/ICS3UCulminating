//
//  Guess.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 2026-06-01.
//

import Foundation

/// Represents a single attempt (guess) made by the player.
/// Conforms to `Identifiable` so it can be easily used in SwiftUI `ForEach` or `List`.
struct Guess: Identifiable {
    
    // MARK: - Stored properties
    
    /// A unique identifier for each guess instance.
    let id = UUID()
    
    /// The 5-letter word string entered by the player.
    var word: String
    
    /// An array containing the evaluation for each of the 5 letters in the word.
    var evaluations: [LetterEvaluation]
    
    // MARK: - Initializer
    
    /// Creates a new guess with an optional word and default 'pending' evaluations.
    /// - Parameters:
    ///   - word: The word string (defaults to empty).
    ///   - evaluations: The initial evaluations (defaults to 5 'pending' states).
    init(word: String = "", evaluations: [LetterEvaluation] = Array(repeating: .pending, count: 5)) {
        self.word = word
        self.evaluations = evaluations
    }
}
