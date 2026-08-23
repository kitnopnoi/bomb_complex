class StageData {
  final int real;
  final int imag;
  final String question;
  final String correct;
  final List<String> options;

  StageData({
    required this.real,
    required this.imag,
    required this.question,
    required this.correct,
    required this.options,
  });
}

String formatComplex(int r, int i) {
  if (i == 0) return '$r';
  if (r == 0) {
    if (i == 1) return 'i';
    if (i == -1) return '-i';
    return '${i}i';
  }
  // มีทั้ง real และ imag — ไม่ใส่วงเล็บ เช่น 2 + 3i, 1 - i
  String sign = i > 0 ? '+' : '-';
  String iStr = i.abs() == 1 ? 'i' : '${i.abs()}i';
  return '$r $sign $iStr';
}

// format จำนวนเชิงซ้อนเดี่ยว ถ้ามีทั้ง real และ imag ใส่วงเล็บ
// เช่น (2, 3) → (2 + 3i), (0, 2) → 2i, (3, 0) → 3, (1, 1) → (1 + i)
String formatTerm(int r, int i) {
  if (r == 0 && i == 0) return '0';
  if (i == 0) return '$r';
  if (r == 0) {
    if (i == 1) return 'i';
    if (i == -1) return '-i';
    return '${i}i';
  }
  // มีทั้ง real และ imag → ใส่วงเล็บ
  String iStr = i == 1 ? 'i' : (i == -1 ? 'i' : '${i.abs()}i');
  String sign = i > 0 ? '+' : '-';
  return '($r $sign $iStr)';
}
