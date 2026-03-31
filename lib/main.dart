import 'package:flutter/material.dart';

int highestStage = 0;
final Set<int> shownHowToStages = {};

void main() {
  runApp(const BombComplexApp());
}

/// APP ROOT

class BombComplexApp extends StatelessWidget {
  const BombComplexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bomb Complex',
      theme: ThemeData(useMaterial3: true),
      home: const MainMenu(),
    );
  }
}

/// STAGE DATA

class StageData {
  final int real;
  final int imag;
  final String correct;
  final List<String> options;

  StageData({
    required this.real,
    required this.imag,
    required this.correct,
    required this.options,
  });
}

/// 📘 STAGES
final List<StageData> stages = [
  StageData(
    real: 2,
    imag: 3,
    correct: '2 + 3i',
    options: ['2 + 3i', '3 + 2i', '-2 + 3i', '2 - 3i', '-3 + 2i', '3 - 2i'],
  ),
  StageData(
    real: -1,
    imag: 2,
    correct: '-1 + 2i',
    options: ['-1 + 2i', '1 + 2i', '-2 + i', '2 - i', '1 - 2i', '-1 - 2i'],
  ),
  StageData(
    real: 3,
    imag: -2,
    correct: '3 - 2i',
    options: ['3 - 2i', '3 + 2i', '-3 - 2i', '2 - 3i', '-2 + 3i', '2 + 3i'],
  ),
  StageData(
    real: 0,
    imag: 4,
    correct: '4i',
    options: ['-4 + 4i', '1 + 4i', '-3 - 2i', '0', '4i', '-4i'],
  ),
  StageData(real: 1, imag: -2, correct: '1 - 2i', options: []),

  StageData(
    real: 0,
    imag: 4,
    correct: '3 + 2i - 3 + 2i',
    options: [
      '0',
      '1 + 4i',
      '3 + 2i - 3 + 2i',
      '7 + i - 6 + 3i',
      '3 - 4i + 4 + 6i',
      '-2i + 2 + 2i',
    ],
  ),
  StageData(
    real: 0,
    imag: 2,
    correct: '4 + i - 4 + i',
    options: [
      '0',
      '4 + i - 4 + i',
      '-3 + 2i',
      '1 + 2i',
      '-2 + 2i',
      '6 - 4i -5',
    ],
  ),

  StageData(
    real: -1,
    imag: 3,
    correct: '- 11 + 4i + 10 - i',
    options: [
      '1 - 3i ',
      '0',
      '- 11 + 4i + 10 - i',
      '3 + 6i + (-3i)',
      '-3 + 6i -2i',
      '3 - 2i +1',
    ],
  ),

  StageData(
    real: -2,
    imag: -2,
    correct: '(3 - 5i) + (-5 + 3i)',
    options: [
      '(0 - 2i)+ (2)',
      '(3 - 5i) + (-5 + 3i)',
      '(-3 + 4i) + (1 - 2i)',
      '(-1 - i) + (-1 + i)',
      '(1 + 2i) - (-1 + 3i)',
      '(2 + 2i) - (1 + 3i)',
    ],
  ),

  StageData(real: -2, imag: 2, correct: '(-5 + 6i) + (3 - 4i)', options: []),

  StageData(
    real: 0,
    imag: 4,
    correct: '2(3 + 2i) + (-6)',
    options: [
      '0(6 - 5i) + i',
      '3 - 2i',
      '3(2) + 2i - 3 + 2i',
      '2(3 + 2i) + (-6)',
      '2(1 + 3i)',
      '3(2 - i)',
    ],
  ),
  StageData(
    real: 1,
    imag: 4,
    correct: '2(2 + 2i) - 3',
    options: [
      '2(2 + 2i) + 3',
      '3 - 2i + 2(1 + 2i)',
      '3(2) + 2i - 3 + 2i',
      '2(3 + 2i) + (-6)',
      '2(1 + 2i)',
      '2(2 + 2i) - 3',
    ],
  ),
  StageData(
    real: -3,
    imag: 4,
    correct: '-5 + 2(1 + 2i)',
    options: [
      '-2(2 + 2i) + 3',
      '-5 + 2(1 + 2i)',
      '-5 + 2(1 - 2i)',
      '2(3 + 2i)',
      '2(1 - 2i) - 3',
      '2(1 + 2i) - 3',
    ],
  ),
  StageData(
    real: 4,
    imag: -2,
    correct: '3(4 - 2i) - 2(4 - 2i)',
    options: [
      '3(4 - 2i) - 2(4 - 2i)',
      '2(3i) - 2(4 - 2i)',
      '4(1 + i) - 3',
      '2(3i) - 2(4 + 2i)',
      '3(2i) + 2(-2 + i)',
      '(1 + i) - 3(2 - i)',
    ],
  ),
  StageData(
    real: -4,
    imag: -4,
    correct: '-2(5 + 4i) + 2(3 + 2i)',
    options: [
      '-2(5 + 4i) + 2(3 + 3i)',
      '2(5 + 4i) - 2(3 + 2i)',
      '-2(5 + 4i) - 2(3 + 2i)',
      '-2(5 + 4i) + 2(3 + 2i)',
      '-2(5 + 4i) + 2(3 + 3i)',
      '2(5 + 4i) + 2(3 + 3i)',
    ],
  ),
  StageData(
    real: 3,
    imag: 2,
    correct: 'i(2 - 3i)',
    options: [
      'i(2 + 3i)',
      '(1 + i)(2 + i)',
      '(2 + i)(2 - i)',
      '(1 + i)(3 + i)',
      'i(2 - 3i)',
      '(2 + 2i)(1 + i)',
    ],
  ),
  StageData(
    real: 1,
    imag: -3,
    correct: '(1 - i)(2 - i)',
    options: [
      'i(3 + i)',
      '(1 - 3i)(1 + i)',
      '(2 + i)(2 - i)',
      '(1 - i)(3 + i)',
      '(1 - i)(2 - i)',
      '(1 - i)(2 + i)',
    ],
  ),
  StageData(
    real: 2,
    imag: 4,
    correct: '(1 + i)(3 + i)',
    options: [
      '(1 - i)(2 + 2i)',
      '(1 + i)(2 + i)',
      '(2 + i)(1 + 2i)',
      '(1 + i)(3 + i)',
      'i(4 + 2i)',
      '(1 + i)(3 - 2i)',
    ],
  ),
  StageData(
    real: 2,
    imag: 0,
    correct: '(1 - i)(1 + i)',
    options: [
      'i(1 + 2i)',
      '(1 - i)(1 - i)',
      '(2 + i)(3 - i)',
      'i(1 + i)',
      '(1 + i)(1 + i)',
      '(1 - i)(1 + i)',
    ],
  ),
  StageData(
    real: 3,
    imag: -1,
    correct: '(1 - i)(2 + i)',
    options: [
      '(1 + i)(2 + i)',
      '(1 - i)(2 + i)',
      '(2 - i)(1 - i)',
      '(1 - i)(3 + i)',
      'i(3 + i)',
      'i(3 - i)',
    ],
  ),
];

/// MAIN MENU
class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline, color: Colors.white),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => const HowToPlayDialog(startPage: 1, endPage: 2),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('💣', style: TextStyle(fontSize: 100)),
              const SizedBox(height: 16),
              const Text(
                'BOMB COMPLEX',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                ),
              ),

              const SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(220, 50),
                ),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const GamePlayPage(stageIndex: 0),
                    ),
                  );
                  setState(() {});
                },
                child: const Text('START GAME', style: TextStyle(fontSize: 18)),
              ),

              const SizedBox(height: 40),

              Text(
                'Highest Stage : $highestStage',
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

///  HOW TO PLAY
class HowToPlayDialog extends StatefulWidget {
  final int startPage;
  final int endPage;

  const HowToPlayDialog({
    super.key,
    required this.startPage,
    required this.endPage,
  });

  @override
  State<HowToPlayDialog> createState() => _HowToPlayDialogState();
}

class _HowToPlayDialogState extends State<HowToPlayDialog> {
  late int currentPage;

  @override
  void initState() {
    super.initState();
    currentPage = widget.startPage;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: 320,
        height: 260,
        child: Center(child: _buildPage(currentPage)),
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (currentPage < widget.endPage) {
              setState(() => currentPage++);
            } else {
              Navigator.pop(context);
            }
          },
          child: Text(currentPage < widget.endPage ? 'NEXT' : 'OK'),
        ),
      ],
    );
  }

  Widget _buildPage(int page) {
    switch (page) {
      case 1:
        return _page(
          'วิธีเล่น',
          'โจทย์จะแสดงกราฟของจำนวนเชิงซ้อน\n'
              'ผู้เล่นต้องเลือก 1 คำตอบจาก 6 ตัวเลือก\n\n'
              'ตอบถูก → ไปด่านถัดไป\n'
              'ตอบผิด → หัวใจลด\n\n'
              'หัวใจหมด = Game Over!\n'
              'ต้องเริ่มใหม่ที่ Stage 1',
        );
      case 2:
        return _page(
          'วิธีเล่น',
          'จำนวนเชิงซ้อนอยู่ในรูป a + bi\n'
              'a = พิกัดแกน x\n'
              'b = พิกัดแกน y\n\n'
              'เส้นสีแดงคือ x = 0 และ y = 0\n\n'
              'ตัวอย่าง (3 , -2)\n'
              'คำตอบคือ 3 - 2i',
        );
      case 3:
        return _page(
          'วิธีเล่น',
          'การบวกลบจำนวนเชิงซ้อน\n'
              '(a + bi) + (c + di)\n'
              '= (a + c) + (b + d)i\n'
              'ตัวอย่าง 1 + 2i + 2 - 4i\n'
              'จะมีค่าเท่ากับ 3 - 2i',
        );
      case 4:
        return _page(
          'วิธีเล่น',
          'การคูณจำนวนเชิงซ้อนด้วยสเกลาร์\n'
              '(a + bi) × c\n'
              '= (ac) + (bc)i\n'
              'ตัวอย่าง (1 + 2i) × 3\n'
              'จะมีค่าเท่ากับ 3 + 6i',
        );
      case 5:
        return _page(
          'วิธีเล่น',
          'การคูณจำนวนเชิงซ้อนด้วยจำนวนเชิงซ้อน\n'
              '(a + bi) × (c + di)\n'
              '= (ac - bd) + (ad + bc)i\n'
              'โดยที่ i² = -1\n'
              'ตัวอย่าง (1 + 2i) × (2 - 4i)\n'
              '= (1×2 - 2×(-4)) + (1×(-4) + 2×2)i\n'
              '= (2 + 8) + (-4 + 4)i\n'
              '= 10 + 0i'
              '= 10',
        );
      case 6:
        return _page(
          'วิธีเล่น',
          'ในทุก ๆ 5 ด่าน จะมีโจทย์พิเศษ\n'
              'โจทย์จะมาในรูปของสมการของจำนวนเชิงซ้อน\n'
              'ผู้เล่นต้องวางระเบิดให้ตรงกับคำตอบของสมการ\n\n'
              'โดยใช้ปุ่มลูกศรควบคุมทิศทางของระเบิด\n'
              'และกดปุ่ม Confirm เมื่อวางระเบิดเสร็จ',
        );
      default:
        return const SizedBox();
    }
  }

  Widget _page(String title, String body) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: '$title\n\n',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          TextSpan(
            text: body,
            style: const TextStyle(fontSize: 15, color: Colors.black),
          ),
        ],
      ),
    );
  }
}

/// =======================
/// GAME PLAY PAGE
/// =======================
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

    // ⭐ แทรก Bomb ทุก ๆ 5 ด่าน
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

  void nextStage() {
    if (widget.stageIndex + 1 < stages.length) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => GamePlayPage(stageIndex: widget.stageIndex + 1),
        ),
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

  Widget _buildMultipleChoice(StageData stage) {
    return Column(
      children: [
        const SizedBox(height: 10),
        SizedBox(
          width: 260,
          height: 260,
          child: CustomPaint(
            painter: ComplexGridPainter(stage.real, stage.imag),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 70),
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

          /// ✅ แสดงโจทย์จริงจากด่าน
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

          /// ปุ่มควบคุมทิศทาง
          SizedBox(
            width: 220,
            height: 150,
            child: Stack(
              alignment: Alignment.center,
              children: [
                /// 🔼 ขึ้น
                Positioned(
                  top: 0,
                  child: ElevatedButton(
                    onPressed: () => setState(() => placedImag++),
                    child: const Icon(Icons.keyboard_arrow_up),
                  ),
                ),

                /// 🔽 ลง
                Positioned(
                  bottom: 0,
                  child: ElevatedButton(
                    onPressed: () => setState(() => placedImag--),
                    child: const Icon(Icons.keyboard_arrow_down),
                  ),
                ),

                /// ◀ ซ้าย
                Positioned(
                  left: 0,
                  child: ElevatedButton(
                    onPressed: () => setState(() => placedReal--),
                    child: const Icon(Icons.keyboard_arrow_left),
                  ),
                ),

                /// ▶ ขวา
                Positioned(
                  right: 0,
                  child: ElevatedButton(
                    onPressed: () => setState(() => placedReal++),
                    child: const Icon(Icons.keyboard_arrow_right),
                  ),
                ),

                /// ✅ ตรงกลาง
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

/// =======================
///  COMPLEX GRID
/// =======================
class ComplexGridPainter extends CustomPainter {
  final int real;
  final int imag;

  ComplexGridPainter(this.real, this.imag);

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()..color = const Color.fromARGB(255, 0, 0, 0);
    final axisPaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2;

    const gridCount = 8;
    final cell = size.width / gridCount;
    final center = gridCount / 2;

    for (int i = 0; i <= gridCount; i++) {
      canvas.drawLine(
        Offset(i * cell, 0),
        Offset(i * cell, size.height),
        gridPaint,
      );
      canvas.drawLine(
        Offset(0, i * cell),
        Offset(size.width, i * cell),
        gridPaint,
      );
    }

    canvas.drawLine(
      Offset(center * cell, 0),
      Offset(center * cell, size.height),
      axisPaint,
    );
    canvas.drawLine(
      Offset(0, center * cell),
      Offset(size.width, center * cell),
      axisPaint,
    );

    final x = (center + real) * cell;
    final y = (center - imag) * cell;

    final tp = TextPainter(
      text: const TextSpan(text: '💣', style: TextStyle(fontSize: 28)),
      textDirection: TextDirection.ltr,
    )..layout();

    tp.paint(canvas, Offset(x - tp.width / 2, y - tp.height / 2));
  }

  @override
  bool shouldRepaint(_) => true;
}
