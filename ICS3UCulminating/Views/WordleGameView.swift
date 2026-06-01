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

// MARK: - Preview

#Preview {
    WordleGameView()
}
