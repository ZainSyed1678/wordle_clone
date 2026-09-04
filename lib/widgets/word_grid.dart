import 'package:flutter/material.dart';
import '../controllers/game_controller.dart';
import '../models/letter_status.dart';

class WordGrid extends StatelessWidget {
  final GameController controller;

  const WordGrid({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(6, (rowIndex) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (colIndex) {
            String char = '';
            LetterStatus status = LetterStatus.initial;

            if (rowIndex < controller.guesses.length) {
              // Past guess
              String guess = controller.guesses[rowIndex];
              char = guess[colIndex];
              status = controller.getGuessStatuses(guess)[colIndex];
            } else if (rowIndex == controller.guesses.length) {
              // Current guess
              if (colIndex < controller.currentGuess.length) {
                char = controller.currentGuess[colIndex];
              }
            }

            return Container(
              margin: const EdgeInsets.all(4),
              width: 55,
              height: 55,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _getBackgroundColor(status),
                border: Border.all(
                  color: status == LetterStatus.initial ? Colors.grey : Colors.transparent,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                char,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: status == LetterStatus.initial ? (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black87) : Colors.white,
                ),
              ),
            );
          }),
        );
      }),
    );
  }

  Color _getBackgroundColor(LetterStatus status) {
    switch (status) {
      case LetterStatus.correct:
        return Colors.green;
      case LetterStatus.present:
        return Colors.amber;
      case LetterStatus.absent:
        return Colors.grey.shade700;
      case LetterStatus.initial:
        return Colors.transparent;
    }
  }
}
