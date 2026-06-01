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
    /// Because it is marked @Observable in the View Model file, 
    /// SwiftUI will automatically track changes to its properties.
    @State var game = WordleGame()
    
    /// The layout for our simple clickable keyboard.
    private let keyboardRows = [
        ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"],
        ["A", "S", "D", "F", "G", "H", "J", "K", "L"],
        ["Enter", "Z", "X", "C", "V", "B", "N", "M", "⌫"]
    ]
    
    // MARK: - Computed properties
    
    var body: some View {
        VStack(spacing: 20) {
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
            }
            
            // Simple Keyboard
            VStack(spacing: 8) {
                ForEach(keyboardRows, id: \.self) { row in
                    HStack(spacing: 6) {
                        ForEach(row, id: \.self) { key in
                            Button(action: {
                                // We call the view model functions based on the key pressed
                                if key == "Enter" {
                                    game.submitGuess()
                                } else if key == "⌫" {
                                    game.removeLetter()
                                } else {
                                    game.addLetter(key)
                                }
                            }) {
                                Text(key)
                                    .font(.system(size: key.count > 1 ? 14 : 18, weight: .bold))
                                    .frame(minWidth: key.count > 1 ? 55 : 32, minHeight: 45)
                                    .background(Color.gray.opacity(0.2))
                                    .foregroundColor(.primary)
                                    .cornerRadius(4)
                            }
                        }
                    }
                }
            }
            .padding(.bottom)
            
            // New Game Button
            Button("New Game") {
                game = WordleGame()
            }
            .buttonStyle(.borderedProminent)
            .padding(.bottom)
        }
        .padding()
    }
}

/// A view representing a single row of 5 letters in the Wordle grid.
struct GuessRowView: View {
    let guess: Guess
    
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
    
    /// Helper to get the letter at a specific position in the word string.
    private func getLetter(at index: Int) -> String {
        let characters = Array(guess.word)
        if index < characters.count {
            return String(characters[index]).uppercased()
        }
        return ""
    }
}

/// A view representing an individual letter tile.
struct LetterTileView: View {
    let letter: String
    let evaluation: LetterEvaluation
    
    var body: some View {
        Text(letter)
            .font(.title)
            .fontWeight(.bold)
            .frame(width: 60, height: 60)
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .border(borderColor, width: 2)
    }
    
    // MARK: - View Helpers
    
    /// Determines the background color based on the letter's evaluation.
    private var backgroundColor: Color {
        switch evaluation {
        case .correct: return .green
        case .misplaced: return .yellow
        case .wrong: return .gray
        case .pending: return .clear
        }
    }
    
    /// Determines the text color based on the evaluation.
    private var foregroundColor: Color {
        evaluation == .pending ? .primary : .white
    }
    
    /// Determines the border color for empty or pending tiles.
    private var borderColor: Color {
        if evaluation == .pending {
            return letter.isEmpty ? .gray.opacity(0.3) : .gray
        }
        return .clear
    }
}

// MARK: - Preview

#Preview {
    WordleGameView()
}
