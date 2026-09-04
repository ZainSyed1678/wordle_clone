# Wordle Clone

A decent Wordle clone built entirely with Flutter and Dart.

## Features
- **Pure Flutter Architecture**: Uses Flutter's built-in `ChangeNotifier` and `ListenableBuilder` for state management, eliminating the need for external packages and keeping the project lightweight.
- **Dynamic Grid**: A fully reactive 6x5 grid that updates in real-time as you type and submit guesses.
- **Interactive Keyboard**: An on-screen custom keyboard that color-codes letters (green, yellow, gray) based on past guesses.
- **Word Validation**: Verifies guesses against a built-in dictionary of over 200 common 5-letter English words.
- **Responsive Theme**: Supports both light and dark mode out-of-the-box.

## Getting Started

1. **Clone the repository:**
   ```bash
   git clone https://github.com/ZainSyed1678/wordle_clone.git
   ```
2. **Navigate to the project directory:**
   ```bash
   cd wordle_clone
   ```
3. **Get dependencies (if any are added in the future):**
   ```bash
   flutter pub get
   ```
4. **Run the app:**
   ```bash
   flutter run
   ```

## Development
This project was built to emphasize pure Dart and Flutter skills, focusing on modular widget design and effective use of the `ChangeNotifier` API for clean game state orchestration.
