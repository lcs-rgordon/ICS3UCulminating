//
//  HistoryDetailView.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 2026-06-01.
//

import SwiftUI

/// A view that shows the full detail of a historical Wordle game.
struct HistoryDetailView: View {
    
    // MARK: - Stored properties
    let completedGame: CompletedGame
    
    // MARK: - Computed properties
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Game Result")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Target Word: \(completedGame.targetWord.uppercased())")
                    .font(.headline)
                
                // Show the actual board as it was when the game ended
                VStack(spacing: 8) {
                    ForEach(completedGame.guesses) { guess in
                        GuessRowView(guess: guess)
                    }
                }
                .padding()
                
                Text("Completed on \(completedGame.dateCompleted.formatted())")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("History Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    HistoryDetailView(completedGame: CompletedGame(
        targetWord: "PIANO",
        guesses: Array(repeating: Guess(), count: 6),
        gameState: .lost,
        dateCompleted: Date()
    ))
}
