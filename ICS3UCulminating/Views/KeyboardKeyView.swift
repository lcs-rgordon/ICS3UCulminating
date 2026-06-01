//
//  KeyboardKeyView.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 2026-06-01.
//

import SwiftUI

/// A view representing a single key on the Wordle keyboard.
struct KeyboardKeyView: View {
    
    // MARK: - Stored properties
    let key: String
    let evaluation: LetterEvaluation
    let action: () -> Void
    
    // MARK: - Computed properties
    var body: some View {
        Button(action: action) {
            Text(key)
                .font(.system(size: key.count > 1 ? 14 : 18, weight: .bold))
                .frame(width: keyWidth, height: 50)
                .background(backgroundColor)
                .foregroundColor(foregroundColor)
                .cornerRadius(4)
        }
    }
    
    // MARK: - View Helpers
    
    /// Calculates a fixed but responsive width for the keys.
    private var keyWidth: CGFloat {
        if key == "Enter" || key == "⌫" {
            return 55
        } else {
            return 34
        }
    }
    
    // MARK: - View Helpers
    
    /// Determines the background color based on the letter's best evaluation so far.
    private var backgroundColor: Color {
        switch evaluation {
        case .correct: return .green
        case .misplaced: return .yellow
        case .wrong: return Color(white: 0.3) // Dark Gray
        case .pending: return Color.gray.opacity(0.2) // Unused/Default
        }
    }
    
    /// Determines the text color.
    private var foregroundColor: Color {
        evaluation == .pending ? .primary : .white
    }
}

#Preview {
    HStack {
        KeyboardKeyView(key: "Q", evaluation: .pending) {}
        KeyboardKeyView(key: "W", evaluation: .wrong) {}
        KeyboardKeyView(key: "E", evaluation: .misplaced) {}
        KeyboardKeyView(key: "R", evaluation: .correct) {}
        KeyboardKeyView(key: "T", evaluation: .pending) {}
        KeyboardKeyView(key: "Y", evaluation: .pending) {}
        KeyboardKeyView(key: "U", evaluation: .pending) {}
        KeyboardKeyView(key: "I", evaluation: .pending) {}
        KeyboardKeyView(key: "O", evaluation: .pending) {}
        KeyboardKeyView(key: "P", evaluation: .pending) {}
    }
}
