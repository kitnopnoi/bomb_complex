import 'dart:math';
import '../models/stage_data.dart';

final _rand = Random();

// บวก: ถ้า term ใดติดลบ ใส่วงเล็บครอบ term นั้น
// เช่น 2 + (-2i), (2 + 3i) + (-2i)
String _fmtAdd(int a, int b, int c, int d) {
  String t1 = formatTerm(a, b);
  String t2 = formatTerm(c, d);
  // ถ้า t2 เริ่มต้นด้วย - ใส่วงเล็บให้
  if (t2.startsWith('-') && !t2.startsWith('(')) t2 = '($t2)';
  return '$t1 + $t2';
}

// scalar: ถ้า term มีวงเล็บอยู่แล้วไม่ต้องเพิ่ม เช่น 2(3 + i), 3(2i)
// ถ้า term เป็นจำนวนเดี่ยว เพิ่มวงเล็บ เช่น 2(3)
String _fmtScalar(int k, int a, int b) {
  String t = formatTerm(a, b);
  if (!t.startsWith('(')) t = '($t)';
  return '$k$t';
}

// คูณ: แต่ละ term ใส่วงเล็บถ้ายังไม่มี เช่น (2 + i)(3), (1)(2 + 3i)
// ถ้า term เดี่ยวไม่มีวงเล็บ ให้เพิ่ม
String _fmtMul(int a, int b, int c, int d) {
  String t1 = formatTerm(a, b);
  String t2 = formatTerm(c, d);
  if (!t1.startsWith('(')) t1 = '($t1)';
  if (!t2.startsWith('(')) t2 = '($t2)';
  return '$t1$t2';
}

StageData generateCoordinate() {
  int real = _rand.nextInt(9) - 4;
  int imag = _rand.nextInt(9) - 4;
  if (real == 0 && imag == 0) imag = 1;

  String correct = formatComplex(real, imag);
  Set<String> options = {correct};
  while (options.length < 6) {
    int r = _rand.nextInt(9) - 4;
    int i = _rand.nextInt(9) - 4;
    if (r == 0 && i == 0) continue;
    options.add(formatComplex(r, i));
  }

  return StageData(
    real: real,
    imag: imag,
    question: '($real, $imag)',
    correct: correct,
    options: options.toList()..shuffle(_rand),
  );
}

StageData generateAddition() {
  int real = 0, imag = 0;
  while (real == 0 && imag == 0) {
    real = _rand.nextInt(9) - 4;
    imag = _rand.nextInt(9) - 4;
  }

  int a = _rand.nextInt(real.abs() + 1) * (real >= 0 ? 1 : -1);
  int c = real - a;
  int b = _rand.nextInt(imag.abs() + 1) * (imag >= 0 ? 1 : -1);
  int d = imag - b;
  String correct = _fmtAdd(a, b, c, d);

  Set<String> options = {correct};
  while (options.length < 6) {
    int fa = _rand.nextInt(5) - 2, fb = _rand.nextInt(5) - 2;
    int fc = _rand.nextInt(5) - 2, fd = _rand.nextInt(5) - 2;
    if (fa + fc == real && fb + fd == imag) continue;
    String opt = _fmtAdd(fa, fb, fc, fd);
    if (opt == correct) continue;
    options.add(opt);
  }

  return StageData(
    real: real,
    imag: imag,
    question: 'สมการใดมีค่าเท่ากับจุดบนกราฟ?',
    correct: correct,
    options: options.toList()..shuffle(_rand),
  );
}

StageData generateScalar() {
  int real = 0, imag = 0;
  int a = 0, b = 0, k = 2;
  while (real == 0 && imag == 0) {
    k = _rand.nextInt(3) + 2;
    a = _rand.nextInt(5) - 2;
    b = _rand.nextInt(5) - 2;
    real = (a * k).clamp(-4, 4);
    imag = (b * k).clamp(-4, 4);
  }
  String correct = _fmtScalar(k, a, b);

  Set<String> options = {correct};
  while (options.length < 6) {
    int fk = _rand.nextInt(3) + 2;
    int fa = _rand.nextInt(5) - 2, fb = _rand.nextInt(5) - 2;
    if (fa * fk == real && fb * fk == imag) continue;
    String opt = _fmtScalar(fk, fa, fb);
    if (opt == correct) continue;
    options.add(opt);
  }

  return StageData(
    real: real,
    imag: imag,
    question: 'สมการใดมีค่าเท่ากับจุดบนกราฟ?',
    correct: correct,
    options: options.toList()..shuffle(_rand),
  );
}

StageData generateMultiplication() {
  int real = 0, imag = 0;
  int a = 0, b = 0, c = 0, d = 0;
  while (real == 0 && imag == 0) {
    a = _rand.nextInt(3) + 1;
    b = _rand.nextInt(3);
    c = _rand.nextInt(3) + 1;
    d = _rand.nextInt(3);
    real = (a * c - b * d).clamp(-4, 4);
    imag = (a * d + b * c).clamp(-4, 4);
  }
  String correct = _fmtMul(a, b, c, d);

  Set<String> options = {correct};
  while (options.length < 6) {
    int fa = _rand.nextInt(3) + 1, fb = _rand.nextInt(3);
    int fc = _rand.nextInt(3) + 1, fd = _rand.nextInt(3);
    if (fa * fc - fb * fd == real && fa * fd + fb * fc == imag) continue;
    String opt = _fmtMul(fa, fb, fc, fd);
    if (opt == correct) continue;
    options.add(opt);
  }

  return StageData(
    real: real,
    imag: imag,
    question: 'สมการใดมีค่าเท่ากับจุดบนกราฟ?',
    correct: correct,
    options: options.toList()..shuffle(_rand),
  );
}

StageData generateRandomStage() {
  int type = _rand.nextInt(4);
  switch (type) {
    case 0:
      return generateCoordinate();
    case 1:
      return generateAddition();
    case 2:
      return generateScalar();
    case 3:
      return generateMultiplication();
    default:
      return generateCoordinate();
  }
}

final List<StageData> stages = [
  StageData(
    real: 2,
    imag: 3,
    question: '(2, 3)',
    correct: '2 + 3i',
    options: ['2 + 3i', '3 + 2i', '-2 + 3i', '2 - 3i', '-3 + 2i', '3 - 2i'],
  ),
  StageData(
    real: -1,
    imag: 2,
    question: '(-1, 2)',
    correct: '-1 + 2i',
    options: ['-1 + 2i', '1 + 2i', '-2 + i', '2 - i', '1 - 2i', '-1 - 2i'],
  ),
  StageData(
    real: 3,
    imag: -2,
    question: '(3, -2)',
    correct: '3 - 2i',
    options: ['3 - 2i', '3 + 2i', '-3 - 2i', '2 - 3i', '-2 + 3i', '2 + 3i'],
  ),
  StageData(
    real: 0,
    imag: 4,
    question: '(0, 4)',
    correct: '4i',
    options: ['-4 + 4i', '1 + 4i', '-3 - 2i', '0', '4i', '-4i'],
  ),
  StageData(
    real: 1,
    imag: -2,
    question: '(1, -2)',
    correct: '1 - 2i',
    options: ['1 - 2i', '1 + 2i', '-1 - 2i', '2 - 1i', '-1 + 2i', '2 + 1i'],
  ),
  StageData(
    real: 0,
    imag: 4,
    question: '3 + 2i - 3 + 2i',
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
    question: '4 + i - 4 + i',
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
    question: '- 11 + 4i + 10 - i',
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
    question: '2(1 + 2i) - 3(1 + 2i)',
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
  StageData(
    real: -2,
    imag: 2,
    question: '(-5 + 6i) + (3 - 4i)',
    correct: '(-5 + 6i) + (3 - 4i)',
    options: [
      '(-5 + 6i) + (3 - 4i)',
      '(-2 + 2i)',
      '(-8 + 10i) - (-3 + 4i)',
      '(-5 + 6i) - (3 - 4i)',
      '(-8 + 10i) - (3 - 4i)',
      '(-2 + 2i) + (3 - 4i)',
    ],
  ),
  StageData(
    real: 0,
    imag: 4,
    question: '2(3 + 2i) + (-6)',
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
    question: '2(2 + 2i) - 3',
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
    question: '-5 + 2(1 + 2i)',
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
    question: '3(4 - 2i) - 2(4 - 2i)',
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
    question: '-2(5 + 4i) + 2(3 + 2i)',
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
    question: 'i(2 - 3i)',
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
    question: '(1 - i)(2 - i)',
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
    question: '(1 + i)(3 + i)',
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
    question: '(1 - i)(1 + i)',
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
    question: '(1 - i)(2 + i)',
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
