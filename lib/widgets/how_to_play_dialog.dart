import 'package:flutter/material.dart';

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
              '= (2 + 8) + (-4 + 4)i\n'
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
      case 7:
        return _page(
          'Endless Mode',
          'โจทย์จะสุ่มมาเรื่อย ๆ \n'
              'ประกอบด้วยทุกประเภทโจทย์ที่มีในด่านปกติ\n\n'
              'ตอบถูก → ได้ 1 คะแนน\n'
              'ตอบผิดครั้งเดียว → Game Over!\n\n'
              'พยายามทำคะแนนให้สูงที่สุด\n'
              'แล้วทำลายสถิติของตัวเอง!',
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
