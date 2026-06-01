//
//  WordleGameView.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 2026-06-01.
//

import SwiftUI

struct WordleGameView: View {
    
    // MARK: - Stored properties
    
    /// The view model that holds the game logic and state.
    /// It is now passed in from the parent view to persist across tab changes.
    var game: WordleGame
    
    /// The layout for our simple clickable keyboard.
    private let keyboardRows = [
        ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"],
        ["A", "S", "D", "F", "G", "H", "J", "K", "L"],
        ["Enter", "Z", "X", "C", "V", "B", "N", "M", "⌫"]
    ]
    
    // MARK: - Computed properties
    
    var body: some View {
        VStack(spacing: 0) {
            
            // Header
            Text("WORDLE")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 10) // Small padding to avoid Dynamic Island
            
            Spacer(minLength: 5)
            
            // Game Board (6 rows of 5 letters)
            VStack(spacing: 8) {
                // We iterate over the 6 guesses stored in the view model
                ForEach(game.guesses) { guess in
                    GuessRowView(guess: guess)
                }
            }
            .padding(.horizontal)
            
            Spacer(minLength: 5)
            
            // Game Status Messages
            ZStack {
                if game.gameState == .won {
                    Text("You Won! 🎉")
                        .font(.headline)
                        .foregroundColor(.green)
                } else if game.gameState == .lost {
                    Text("Game Over. The word was: \(game.targetWord.uppercased())")
                        .font(.headline)
                        .foregroundColor(.red)
                } else {
                    // Empty space to maintain layout consistency
                    Text(" ")
                        .font(.headline)
                }
            }
            .padding(.vertical, 8)
            
            // Simple Keyboard
            VStack(spacing: 8) {
                ForEach(keyboardRows, id: \.self) { row in
                    HStack(spacing: 6) {
                        ForEach(row, id: \.self) { key in
                            // Use the new KeyboardKeyView to show feedback
                            KeyboardKeyView(
                                key: key,
                                evaluation: game.keyboardEvaluations[key.lowercased()] ?? .pending
                            ) {
                                // Keyboard action logic
                                if key == "Enter" {
                                    game.submitGuess()
                                } else if key == "⌫" {
                                    game.removeLetter()
                                } else {
                                    game.addLetter(key)
                                }
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 5)
            
            Spacer(minLength: 15)
            
            // New Game Button
            Button("New Game") {
                game.startNewGame()
            }
            .buttonStyle(.borderedProminent)
            .padding(.bottom, 10)
        }
    }
}

// MARK: - Preview

#Preview {
    WordleGameView(game: WordleGame())
}
