import 'package:flutter/material.dart';
import '../models/letter_status.dart';

class Keyboard extends StatelessWidget {
  final Map<String, LetterStatus> keyboardStatus;
  final Function(String) onKeyTapped;

  const Keyboard({
    super.key,
    required this.keyboardStatus,
    required this.onKeyTapped,
  });

  @override
  Widget build(BuildContext context) {
    const keys = [
      ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
      ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
      ['ENTER', 'Z', 'X', 'C', 'V', 'B', 'N', 'M', 'BACK'],
    ];

    return Column(
      children: keys.map((row) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: row.map((key) {
            bool isSpecial = key == 'ENTER' || key == 'BACK';
            LetterStatus status = keyboardStatus[key] ?? LetterStatus.initial;
            
            return Padding(
              padding: const EdgeInsets.all(2.0),
              child: GestureDetector(
                onTap: () => onKeyTapped(key),
                child: Container(
                  width: isSpecial ? 60 : 32,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: _getKeyColor(context, status),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    key,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: status == LetterStatus.initial 
                        ? (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black87) 
                        : Colors.white,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        );
      }).toList(),
    );
  }

  Color _getKeyColor(BuildContext context, LetterStatus status) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    switch (status) {
      case LetterStatus.correct:
        return Colors.green;
      case LetterStatus.present:
        return Colors.amber;
      case LetterStatus.absent:
        return isDark ? Colors.grey.shade800 : Colors.grey.shade600;
      case LetterStatus.initial:
        return isDark ? Colors.grey.shade700 : Colors.grey.shade300;
    }
  }
}
