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
    
    /// Tracks the currently selected tab.
    @State private var selectedTab: AppTab = .play
    
    /// Tracks focus to ensure keyboard events are captured.
    @FocusState private var isFocused: Bool
    
    // MARK: - Computed properties
    var body: some View {
        TabView(selection: $selectedTab) {
            // Tab 1: Active Game
            WordleGameView(game: game)
                .tag(AppTab.play)
                .tabItem {
                    Label("Play", systemImage: "gamecontroller")
                }
            
            // Tab 2: History
            GameHistoryView(game: game)
                .tag(AppTab.history)
                .tabItem {
                    Label("History", systemImage: "list.bullet.rectangle")
                }
        }
        // Ensure the TabView itself or its container can receive focus
        .focusable()
        .focused($isFocused)
        // Request focus when the app appears
        .onAppear {
            isFocused = true
        }
        // Re-request focus when switching back to the Play tab
        .onChange(of: selectedTab) { _, newValue in
            if newValue == .play {
                isFocused = true
            }
        }
        // Handle physical keyboard input globally at the TabView level.
        .onKeyPress { keyPress in
            // Only process keyboard input if we are on the Play tab
            if selectedTab == .play {
                handleGlobalKeyPress(keyPress)
                return .handled
            }
            return .ignored
        }
    }
    
    // MARK: - Functions
    
    /// Processes key presses from a physical keyboard and routes them to the game logic.
    private func handleGlobalKeyPress(_ keyPress: KeyPress) {
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

#Preview {
    MainTabView()
}
