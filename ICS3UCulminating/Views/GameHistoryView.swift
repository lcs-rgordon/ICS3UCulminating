//
//  GameHistoryView.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 2026-06-01.
//

import SwiftUI

/// A view that displays a scrollable list of previously completed Wordle games.
struct GameHistoryView: View {
    
    // MARK: - Stored properties
    
    /// The view model containing the history records.
    var game: WordleGame
    
    // MARK: - Computed properties
    var body: some View {
        NavigationStack {
            Group {
                if game.history.isEmpty {
                    VStack(spacing: 20) {
                        Image(systemName: "clock.arrow.circlepath")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)
                        Text("No games played yet.")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                } else {
                    List(game.history) { historyItem in
                        NavigationLink {
                            HistoryDetailView(completedGame: historyItem)
                        } label: {
                            HistoryItemView(completedGame: historyItem)
                        }
                    }
                }
            }
            .navigationTitle("Game History")
        }
    }
}

#Preview {
    GameHistoryView(game: WordleGame())
}
