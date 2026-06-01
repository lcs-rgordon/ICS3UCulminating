# Wordle Puzzle Game

This project implements a version of the popular Wordle game using Swift and SwiftUI.

## Game Rules

1. **Objective**: Guess the hidden five-letter word in six tries.
2. **Input**: Each guess must be a valid five-letter word.
3. **Feedback**:
   - **Green**: The letter is correct and in the right position.
   - **Yellow**: The letter is in the word but in the wrong position.
   - **Gray**: The letter is not in the word.

---

## Example Game Session

**Target Word**: `APPLE`

### Step 1: First Guess
- **Player Guesses**: `BEACH`
- **Evaluation**:
  - `B`: Not in word (**Gray**)
  - `E`: In word, wrong spot (**Yellow**)
  - `A`: In word, wrong spot (**Yellow**)
  - `C`: Not in word (**Gray**)
  - `H`: Not in word (**Gray**)
- **Board State**: `[Gray, Yellow, Yellow, Gray, Gray]`

### Step 2: Second Guess
- **Player Guesses**: `PLANE`
- **Evaluation**:
  - `P`: Correct spot (**Green**)
  - `L`: Correct spot (**Green**)
  - `A`: In word, wrong spot (**Yellow**)
  - `N`: Not in word (**Gray**)
  - `E`: Correct spot (**Green**)
- **Board State**: `[Green, Green, Yellow, Gray, Green]`

### Step 3: Third Guess
- **Player Guesses**: `APPLE`
- **Evaluation**:
  - `A`: Correct spot (**Green**)
  - `P`: Correct spot (**Green**)
  - `P`: Correct spot (**Green**)
  - `L`: Correct spot (**Green**)
  - `E`: Correct spot (**Green**)
- **Result**: **WON!** 🎉

---

## Project Structure

- **Model/Wordle.swift**: Contains data structures (`Guess`, `LetterEvaluation`, `GameState`).
- **Model/WordList.swift**: Contains a list of possible target words.
- **ViewModels/WordleGame.swift**: The main logic controller (`WordleGame`) that manages the game state using the `Observation` framework.
- **Views/**: (To be implemented) SwiftUI views for the game board and keyboard.
