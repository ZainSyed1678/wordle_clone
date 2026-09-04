import 'package:flutter/material.dart';
import '../controllers/game_controller.dart';
import '../widgets/word_grid.dart';
import '../widgets/keyboard.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final GameController _controller = GameController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wordle Clone', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              _controller.reset();
            },
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: _controller,
        builder: (context, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 20),
              if (_controller.message.isNotEmpty)
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.dark 
                            ? Colors.white.withValues(alpha: 0.9) 
                            : Colors.black.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _controller.message,
                        style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark 
                              ? Colors.black 
                              : Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (_controller.hasWon) ...[
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _controller.reset,
                        child: const Text('Next'),
                      ),
                    ]
                  ],
                )
              else
                const SizedBox(height: 36), // Preserve height when no message
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: WordGrid(controller: _controller),
                  ),
                ),
              ),
              Keyboard(
                keyboardStatus: _controller.keyboardStatus,
                onKeyTapped: _controller.onKeyTapped,
              ),
              const SizedBox(height: 40),
            ],
          );
        },
      ),
    );
  }
}
