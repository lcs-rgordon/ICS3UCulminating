//
//  HistoryItemView.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 2026-06-01.
//

import SwiftUI

/// A view representing a single summarized game in the history list.
struct HistoryItemView: View {
    
    // MARK: - Stored properties
    let completedGame: CompletedGame
    
    // MARK: - Computed properties
    var body: some View {
        HStack(spacing: 15) {
            // Small preview of the target word in tiles
            HStack(spacing: 2) {
                ForEach(Array(completedGame.targetWord.enumerated()), id: \.offset) { _, char in
                    Text(String(char).uppercased())
                        .font(.caption)
                        .fontWeight(.bold)
                        .frame(width: 25, height: 25)
                        .background(completedGame.gameState == .won ? Color.green : Color.red.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(2)
                }
            }
            
            VStack(alignment: .leading) {
                Text(completedGame.targetWord.uppercased())
                    .font(.headline)
                
                Text(attemptsCaption)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            // Result icon
            Image(systemName: completedGame.gameState == .won ? "checkmark.circle.fill" : "xmark.circle.fill")
                .foregroundColor(completedGame.gameState == .won ? .green : .red)
        }
        .padding(.vertical, 8)
    }
    
    /// Returns a human-readable caption for the number of attempts.
    private var attemptsCaption: String {
        if completedGame.gameState == .won {
            return "Solved in \(completedGame.attemptsUsed) guesses"
        } else {
            return "Failed after 6 guesses"
        }
    }
}

#Preview {
    HistoryItemView(completedGame: CompletedGame(
        targetWord: "APPLE",
        guesses: [],
        gameState: .won,
        dateCompleted: Date()
    ))
}
