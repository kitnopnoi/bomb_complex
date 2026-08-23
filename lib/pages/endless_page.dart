import 'package:flutter/material.dart';
import '../services/progress_service.dart';
import '../data/stages.dart';
import '../models/stage_data.dart';
import '../painters/complex_grid_painter.dart';

class EndlessPage extends StatefulWidget {
  const EndlessPage({super.key});

  @override
  State<EndlessPage> createState() => _EndlessPageState();
}

class _EndlessPageState extends State<EndlessPage> {
  late StageData current;
  late List<String> shuffledOptions;
  int score = 0;

  @override
  void initState() {
    super.initState();
    _loadNextQuestion();
  }

  void _loadNextQuestion() {
    current = generateRandomStage();
    shuffledOptions = List<String>.from(current.options)..shuffle();
  }

  void nextQuestion() {
    setState(() {
      score++;
      _loadNextQuestion();
    });
  }

  void gameOver() async {
    if (score > highScore) {
      highScore = score;
      await saveProgress();
    }

    if (!mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('💀 Game Over'),
        content: Text('Score: $score\nHigh Score: $highScore'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Back Menu'),
          ),
        ],
      ),
    );
  }

  void checkAnswer(String answer) {
    if (answer == current.correct) {
      nextQuestion();
    } else {
      gameOver();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Endless | Score: $score'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Center(
              child: Text(
                '🏆 $highScore',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          SizedBox(
            width: 260,
            height: 260,
            child: CustomPaint(
              painter: ComplexGridPainter(current.real, current.imag),
            ),
          ),
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.all(16),
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 3,
              children: shuffledOptions
                  .map(
                    (o) => ElevatedButton(
                      onPressed: () => checkAnswer(o),
                      child: Text(
                        o,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
