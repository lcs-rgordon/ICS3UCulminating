//
//  MainTabView.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 2026-06-01.
//

import SwiftUI

/// The root container for the app, providing tab-based navigation.
struct MainTabView: View {
    
    // MARK: - Stored properties
    
    /// The shared view model that persists across tab changes.
    /// This ensures history is maintained while the user is playing.
    @State private var game = WordleGame()
    
    // MARK: - Computed properties
    var body: some View {
        TabView {
            // Tab 1: Active Game
            WordleGameView(game: game)
                .tabItem {
                    Label("Play", systemImage: "gamecontroller")
                }
            
            // Tab 2: History
            GameHistoryView(game: game)
                .tabItem {
                    Label("History", systemImage: "list.bullet.rectangle")
                }
        }
    }
}

#Preview {
    MainTabView()
}
