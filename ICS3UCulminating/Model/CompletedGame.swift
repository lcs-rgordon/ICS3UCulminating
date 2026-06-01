//
//  CompletedGame.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 2026-06-01.
//

import Foundation

/// Represents a finished Wordle game to be stored in history.
struct CompletedGame: Identifiable {
    
    // MARK: - Stored properties
    
    /// Unique identifier for the historical record.
    let id = UUID()
    
    /// The target word that was being guessed.
    let targetWord: String
    
    /// The final list of guesses made by the player.
    let guesses: [Guess]
    
    /// The final state of the game (won or lost).
    let gameState: GameState
    
    /// The date and time the game was completed.
    let dateCompleted: Date
    
    // MARK: - Computed properties
    
    /// Returns the number of attempts used (1 to 6).
    var attemptsUsed: Int {
        var count = 0
        for guess in guesses {
            if guess.evaluations.contains(where: { $0 != .pending }) {
                count += 1
            }
        }
        return count
    }
}
