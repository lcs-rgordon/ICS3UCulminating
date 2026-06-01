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
    
    /// Tracks whether the main view has focus to receive keyboard events.
    @FocusState private var isFocused: Bool
    
    /// The layout for our simple clickable keyboard.
    private let keyboardRows = [
        ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"],
        ["A", "S", "D", "F", "G", "H", "J", "K", "L"],
        ["Enter", "Z", "X", "C", "V", "B", "N", "M", "⌫"]
    ]
    
    // MARK: - Computed properties
    
    var body: some View {
        VStack(spacing: 15) {
            // Header
            Text("WORDLE")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Spacer()
            
            // Game Board (6 rows of 5 letters)
            VStack(spacing: 8) {
                // We iterate over the 6 guesses stored in the view model
                ForEach(game.guesses) { guess in
                    GuessRowView(guess: guess)
                }
            }
            
            Spacer()
            
            // Game Status Messages
            if game.gameState == .won {
                Text("You Won! 🎉")
                    .font(.headline)
                    .foregroundColor(.green)
            } else if game.gameState == .lost {
                Text("Game Over. The word was: \(game.targetWord.uppercased())")
                    .font(.headline)
                    .foregroundColor(.red)
            } else {
                Text("Game in progress")
                    .opacity(0)
            }
            
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
            .padding(.bottom)
            
            // New Game Button
            Button("New Game") {
                game.startNewGame()
            }
            .buttonStyle(.borderedProminent)
            .padding(.bottom)
        }
        .padding()
        // Ensure the view is focused when it appears to receive keyboard events
        .focusable()
        .focused($isFocused)
        .onAppear {
            isFocused = true
        }
        // Handle physical keyboard input
        .onKeyPress { keyPress in
            handleKeyPress(keyPress)
            return .handled
        }
    }
    
    // MARK: - Functions
    
    /// Processes key presses from a physical keyboard.
    private func handleKeyPress(_ keyPress: KeyPress) {
        let key = keyPress.characters
        
        if keyPress.key == .return {
            game.submitGuess()
        } else if keyPress.key == .delete || keyPress.key == .deleteForward {
            game.removeLetter()
        } else if key.count == 1 {
            // Check if the character is a letter
            let letters = CharacterSet.letters
            if let firstChar = key.unicodeScalars.first, letters.contains(firstChar) {
                game.addLetter(key)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    WordleGameView(game: WordleGame())
}
