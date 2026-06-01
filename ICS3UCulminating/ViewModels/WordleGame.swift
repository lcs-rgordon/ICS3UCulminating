//
//  WordleGame.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 2026-06-01.
//

import Foundation
import Observation

// VIEW MODEL

/// This class manages the state and logic for a game of Wordle.
/// It acts as the "brain" of the game, handling user input and calculating feedback.
@Observable
class WordleGame {
    
    // MARK: - Stored properties
    
    /// The secret word the player is trying to guess.
    var targetWord: String
    
    /// A list of 6 guesses, representing the player's attempts.
    /// Initialized with 6 empty guesses.
    var guesses: [Guess]
    
    /// The index of the guess the player is currently typing (0 to 5).
    var currentGuessIndex: Int
    
    /// The string representing the characters the player has typed for the current attempt.
    var currentWord: String
    
    /// The current status of the game (inProgress, won, or lost).
    var gameState: GameState
    
    // MARK: - Initializers
    
    /// Initializes a new game with a specific target word.
    /// - Parameter targetWord: The 5-letter word to be guessed.
    init(targetWord: String) {
        // We convert to lowercase to ensure comparisons are case-insensitive
        self.targetWord = targetWord.lowercased()
        
        // Start at the first guess (index 0) with no characters typed
        self.currentGuessIndex = 0
        self.currentWord = ""
        self.gameState = .inProgress
        
        // Prepare 6 empty guess slots for the game board
        self.guesses = []
        for _ in 1...6 {
            self.guesses.append(Guess())
        }
    }
    
    /// Initializes a new game using a random word from the provided word list.
    convenience init() {
        let randomWord = wordList.randomElement() ?? "apple"
        self.init(targetWord: randomWord)
    }
    
    // MARK: - Functions
    
    /// Adds a letter to the current guess attempt.
    /// - Parameter letter: The character to add.
    func addLetter(_ letter: String) {
        // Don't add letters if the game is over
        guard gameState == .inProgress else { return }
        
        // Only add if we haven't reached the 5-letter limit for the current guess
        if currentWord.count < 5 {
            currentWord.append(letter.lowercased())
            // Update the guess object in the array so the UI reflects the change
            guesses[currentGuessIndex].word = currentWord
        }
    }
    
    /// Removes the last letter from the current guess attempt (Backspace).
    func removeLetter() {
        // Don't remove letters if the game is over
        guard gameState == .inProgress else { return }
        
        // Only remove if there's something to remove
        if currentWord.isEmpty == false {
            currentWord.removeLast()
            // Update the guess object in the array
            guesses[currentGuessIndex].word = currentWord
        }
    }
    
    /// Validates the current guess and moves to the next turn or ends the game.
    func submitGuess() {
        // Check if the game is still active and if the word is exactly 5 letters
        guard gameState == .inProgress else { return }
        guard currentWord.count == 5 else { return }
        
        // Calculate the feedback (Green/Yellow/Gray) for each letter
        let evaluation = evaluate(guess: currentWord)
        guesses[currentGuessIndex].evaluations = evaluation
        
        // Check for win condition: guess matches the target word exactly
        if currentWord == targetWord {
            gameState = .won
        } else if currentGuessIndex == 5 {
            // Check for loss condition: player just finished their 6th attempt
            gameState = .lost
        } else {
            // If the game continues, move to the next row and reset the current typing buffer
            currentGuessIndex += 1
            currentWord = ""
        }
    }
    
    /// Internal logic to compare a guess against the target word.
    /// It handles duplicate letters correctly (e.g., if target is 'APPLE' and guess is 'PEEPS').
    /// - Parameter guess: The 5-letter word to evaluate.
    /// - Returns: An array of 5 evaluations corresponding to each letter.
    private func evaluate(guess: String) -> [LetterEvaluation] {
        // Start by assuming everything is wrong
        var result: [LetterEvaluation] = Array(repeating: .wrong, count: 5)
        
        // We use arrays of characters for easier index-based access
        var targetCharacters: [Character] = Array(targetWord)
        let guessCharacters: [Character] = Array(guess)
        
        // FIRST PASS: Identify correct letters (Green)
        // These are letters that match exactly in both character and position.
        for i in 0..<5 {
            if guessCharacters[i] == targetCharacters[i] {
                result[i] = .correct
                // We "remove" the character from the target so it's not counted again for misplaced letters
                targetCharacters[i] = " " 
            }
        }
        
        // SECOND PASS: Identify misplaced letters (Yellow)
        // These are letters that exist in the word but are in the wrong spot.
        for i in 0..<5 {
            // Only check letters that weren't already marked as correct
            if result[i] != .correct {
                for j in 0..<5 {
                    // If the character matches a remaining (unmatched) character in the target
                    if targetCharacters[j] != " " && guessCharacters[i] == targetCharacters[j] {
                        result[i] = .misplaced
                        // Mark this target character as "used" so it doesn't match another guess letter
                        targetCharacters[j] = " "
                        break
                    }
                }
            }
        }
        
        return result
    }
}
