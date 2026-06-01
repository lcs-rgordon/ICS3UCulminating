//
//  LetterEvaluation.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 2026-06-01.
//

import Foundation

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
