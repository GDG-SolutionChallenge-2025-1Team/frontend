import 'package:flutter/material.dart';
import 'dart:math' as math;

class WavePainter extends CustomPainter {
  final Color color;
  final bool isTopWave;

  WavePainter({
    required this.color,
    required this.isTopWave,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();

    if (isTopWave) {
      path.moveTo(0, 0);

      // 시작점을 왼쪽 상단으로 설정
      var x = 0.0;
      var y = size.height * 0.8; // 파도의 기본 높이
      path.lineTo(0, y);

      // 파도 그리기
      while (x < size.width) {
        // sin 함수를 사용하여 물결 효과 생성
        // x/50: 파도의 주기 조절
        // * 20: 파도의 높이 진폭 조절
        y = size.height * 0.8 + math.sin(x / 50) * 20;
        path.lineTo(x, y);
        x += 5; // 파도의 세밀도 조절
      }

      path.lineTo(size.width, 0);
      path.close();
    } else {
      var x = 0.0;
      var y = size.height * 0.2; // 아래쪽 파도의 기본 높이
      path.moveTo(0, y);

      // 파도 그리기
      while (x < size.width) {
        // 위쪽 파도와 반대 위상을 가지도록 설정
        y = size.height * 0.2 + math.sin(x / 50 + math.pi) * 20;
        path.lineTo(x, y);
        x += 5;
      }

      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
      path.close();
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
