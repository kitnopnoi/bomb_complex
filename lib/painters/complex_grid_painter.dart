import 'package:flutter/material.dart';

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
