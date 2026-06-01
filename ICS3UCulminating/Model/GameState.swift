//
//  GameState.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 2026-06-01.
//

import Foundation

/// Represents the possible states of a Wordle game session.
enum GameState {
    /// The player is still making guesses.
    case inProgress
    
    /// The player has correctly guessed the target word.
    case won
    
    /// The player has used all six attempts without guessing the word.
    case lost
}
