import 'dart:math';
import 'package:flutter/material.dart';
import '../models/letter_status.dart';
import '../constants/words.dart';

class GameController extends ChangeNotifier {
  String targetWord = '';
  List<String> guesses = [];
  String currentGuess = '';
  bool hasWon = false;
  bool hasLost = false;
  String message = '';

  Map<String, LetterStatus> keyboardStatus = {};

  GameController() {
    _initGame();
  }

  void _initGame() {
    final random = Random();
    targetWord = wordList[random.nextInt(wordList.length)];
    guesses = [];
    currentGuess = '';
    hasWon = false;
    hasLost = false;
    message = '';
    keyboardStatus.clear();
    notifyListeners();
  }

  void reset() {
    _initGame();
  }

  void onKeyTapped(String key) {
    if (hasWon || hasLost) return;

    if (key == 'ENTER') {
      _submitGuess();
    } else if (key == 'DEL' || key == 'BACK') {
      if (currentGuess.isNotEmpty) {
        currentGuess = currentGuess.substring(0, currentGuess.length - 1);
        message = '';
        notifyListeners();
      }
    } else {
      if (currentGuess.length < 5) {
        currentGuess += key;
        message = '';
        notifyListeners();
      }
    }
  }

  void _submitGuess() {
    if (currentGuess.length != 5) {
      message = 'Not enough letters';
      notifyListeners();
      return;
    }

    if (!wordList.contains(currentGuess)) {
      message = 'Not in word list';
      notifyListeners();
      return;
    }

    guesses.add(currentGuess);
    _updateKeyboardStatus(currentGuess);

    if (currentGuess == targetWord) {
      hasWon = true;
      message = 'Word Guessed!';
    } else if (guesses.length >= 6) {
      hasLost = true;
      message = targetWord;
    }

    currentGuess = '';
    notifyListeners();
  }

  void _updateKeyboardStatus(String guess) {
    List<LetterStatus> statuses = getGuessStatuses(guess);
    for (int i = 0; i < guess.length; i++) {
      String char = guess[i];
      LetterStatus status = statuses[i];
      
      // Only upgrade status, don't downgrade
      LetterStatus current = keyboardStatus[char] ?? LetterStatus.initial;
      if (status == LetterStatus.correct) {
        keyboardStatus[char] = status;
      } else if (status == LetterStatus.present && current != LetterStatus.correct) {
        keyboardStatus[char] = status;
      } else if (status == LetterStatus.absent && current == LetterStatus.initial) {
        keyboardStatus[char] = status;
      }
    }
  }

  List<LetterStatus> getGuessStatuses(String guess) {
    List<LetterStatus> statuses = List.filled(5, LetterStatus.absent);
    List<bool> targetUsed = List.filled(5, false);

    // First pass: find correct letters
    for (int i = 0; i < 5; i++) {
      if (guess[i] == targetWord[i]) {
        statuses[i] = LetterStatus.correct;
        targetUsed[i] = true;
      }
    }

    // Second pass: find present letters
    for (int i = 0; i < 5; i++) {
      if (statuses[i] == LetterStatus.correct) continue;

      for (int j = 0; j < 5; j++) {
        if (!targetUsed[j] && guess[i] == targetWord[j]) {
          statuses[i] = LetterStatus.present;
          targetUsed[j] = true;
          break;
        }
      }
    }

    return statuses;
  }
}
