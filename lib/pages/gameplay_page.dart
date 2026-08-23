import 'package:flutter/material.dart';
import '../models/stage_data.dart';
import '../data/stages.dart';
import '../services/progress_service.dart';
import '../painters/complex_grid_painter.dart';
import '../widgets/how_to_play_dialog.dart';

class GamePlayPage extends StatefulWidget {
  final int stageIndex;

  const GamePlayPage({super.key, required this.stageIndex});

  @override
  State<GamePlayPage> createState() => _GamePlayPageState();
}

class _GamePlayPageState extends State<GamePlayPage>
    with SingleTickerProviderStateMixin {
  int lives = 3;

  late AnimationController _controller;
  late Animation<double> _shake;

  bool showBomb = false;

  int placedReal = 0;
  int placedImag = 0;

  late List<String> shuffledOptions;

  @override
  void initState() {
    super.initState();

    shuffledOptions = List<String>.from(stages[widget.stageIndex].options)
      ..shuffle();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _shake = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: -10), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -10, end: 10), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 10, end: -10), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -10, end: 10), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 10, end: 0), weight: 1),
    ]).animate(_controller);

    if ((widget.stageIndex + 1) % 5 == 0) {
      showBomb = true;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!shownHowToStages.contains(widget.stageIndex)) {
          shownHowToStages.add(widget.stageIndex);
          showDialog(
            context: context,
            builder: (_) => const HowToPlayDialog(startPage: 6, endPage: 6),
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void wrong() {
    _controller.forward(from: 0);
    setState(() => lives--);

    if (lives == 0) {
      Future.delayed(const Duration(milliseconds: 400), () {
        if (!mounted) return;
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => AlertDialog(
            title: const Text('💀 Game Over'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text('Back to Menu'),
              ),
            ],
          ),
        );
      });
    }
  }

  void nextStage() async {
    int next = widget.stageIndex + 1;

    if (next > highestStage) {
      highestStage = next;
      await saveProgress();
    }

    if (!mounted) return;
    if (next < stages.length) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => GamePlayPage(stageIndex: next)),
      );
    } else {
      Navigator.pop(context);
    }
  }

  void checkAnswer(String answer) {
    final stage = stages[widget.stageIndex];

    if (answer == stage.correct) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          title: const Text('🎉 Congratulation'),
          content: const Text('ผ่านด่านแล้ว'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                nextStage();
              },
              child: const Text('Next Stage'),
            ),
          ],
        ),
      );
    } else {
      wrong();
    }
  }

  void checkBombAnswer() {
    final stage = stages[widget.stageIndex];

    if (placedReal == stage.real && placedImag == stage.imag) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          title: const Text('🎉 Congratulation'),
          content: const Text('ผ่านด่านแล้ว'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                nextStage();
              },
              child: const Text('Next Stage'),
            ),
          ],
        ),
      );
    } else {
      wrong();
    }
  }

  @override
  Widget build(BuildContext context) {
    final stage = stages[widget.stageIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Stage ${widget.stageIndex + 1}'),
        actions: List.generate(
          lives,
          (_) => const Padding(
            padding: EdgeInsets.only(right: 6),
            child: Text('❤️', style: TextStyle(fontSize: 40)),
          ),
        ),
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            children: [
              Transform.translate(
                offset: Offset(_shake.value, 0),
                child: child,
              ),
              if (_controller.isAnimating)
                IgnorePointer(
                  child: Opacity(
                    opacity: 0.5 * (1 - _controller.value),
                    child: Container(color: Colors.red),
                  ),
                ),
            ],
          );
        },
        child: showBomb ? _buildBomb(stage) : _buildMultipleChoice(stage),
      ),
    );
  }

  bool _isCoordinateQuestion(StageData stage) {
    return stage.question.startsWith('(') && stage.question.contains(',');
  }

  Widget _buildMultipleChoice(StageData stage) {
    final isCoord = _isCoordinateQuestion(stage);
    return Column(
      children: [
        const SizedBox(height: 10),
        SizedBox(
          width: 260,
          height: 260,
          child: isCoord
              ? CustomPaint(painter: ComplexGridPainter(stage.real, stage.imag))
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      stage.question,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
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
    );
  }

  Widget _buildBomb(StageData stage) {
    return Align(
      alignment: const Alignment(0, -0.35),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "💣 PLACE THE BOMB",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            stage.correct,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 260,
            height: 260,
            child: CustomPaint(
              painter: ComplexGridPainter(placedReal, placedImag),
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: 220,
            height: 150,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 0,
                  child: ElevatedButton(
                    onPressed: () => setState(
                      () => placedImag = (placedImag + 1).clamp(-4, 4),
                    ),
                    child: const Icon(Icons.keyboard_arrow_up),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: ElevatedButton(
                    onPressed: () => setState(
                      () => placedImag = (placedImag - 1).clamp(-4, 4),
                    ),
                    child: const Icon(Icons.keyboard_arrow_down),
                  ),
                ),
                Positioned(
                  left: 0,
                  child: ElevatedButton(
                    onPressed: () => setState(
                      () => placedReal = (placedReal - 1).clamp(-4, 4),
                    ),
                    child: const Icon(Icons.keyboard_arrow_left),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: ElevatedButton(
                    onPressed: () => setState(
                      () => placedReal = (placedReal + 1).clamp(-4, 4),
                    ),
                    child: const Icon(Icons.keyboard_arrow_right),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                  ),
                  onPressed: checkBombAnswer,
                  child: const Text(
                    "CONFIRM",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
