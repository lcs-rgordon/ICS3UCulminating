//
//  Wordle.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 2026-06-01.
//

import Foundation

// MARK: - Enums

/// Represents the feedback for a single letter in a guess.
/// This is used to determine the color of the tile in the UI.
enum LetterEvaluation: String {
    /// The letter is in the correct position (Green).
    case correct
    
    /// The letter is in the word but in the wrong position (Yellow).
    case misplaced
    
    /// The letter is not in the word at all (Gray).
    case wrong
    
    /// The letter has been typed but the guess has not been submitted yet (Default/White).
    case pending
}

/// Represents the possible states of a Wordle game session.
enum GameState {
    /// The player is still making guesses.
    case inProgress
    
    /// The player has correctly guessed the target word.
    case won
    
    /// The player has used all six attempts without guessing the word.
    case lost
}

// MARK: - Structs

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
