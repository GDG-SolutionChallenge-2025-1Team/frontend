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

      var x = 0.0;
      var y = size.height * 0.8;
      path.lineTo(0, y);

      while (x < size.width) {
        y = size.height * 0.8 + math.sin(x / 50) * 20;
        path.lineTo(x, y);
        x += 5;
      }

      path.lineTo(size.width, 0);
      path.close();
    } else {
      var x = 0.0;
      var y = size.height * 0.2;
      path.moveTo(0, y);

      while (x < size.width) {
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
