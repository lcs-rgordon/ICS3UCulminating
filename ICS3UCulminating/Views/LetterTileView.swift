//
//  LetterTileView.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 2026-06-01.
//

import SwiftUI

/// A view representing an individual letter tile.
struct LetterTileView: View {
    
    // MARK: - Stored properties
    let letter: String
    let evaluation: LetterEvaluation
    
    // MARK: - Computed properties
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

#Preview {
    LetterTileView(letter: "A", evaluation: .correct)
}
