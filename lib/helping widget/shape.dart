import 'package:flutter/material.dart';

class RhomboidPainter extends CustomPainter {
  final Color color;

  RhomboidPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = color;

    double centerX = size.width / 2;
    double centerY = size.height / 2;
    double width = size.width * 2 / 3;
    double height = size.height * 2 / 3;

    Path path = Path();
    path.moveTo(centerX - width / 3, centerY);
    path.lineTo(centerX, centerY - height / 2);
    path.lineTo(centerX + width / 3, centerY);
    path.lineTo(centerX, centerY + height / 2);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(RhomboidPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

class Rhomboid extends StatelessWidget {
  final double width;
  final double height;
  final Color color;

  const Rhomboid({super.key, this.width = 100, this.height = 100, this.color =const  Color(0xFF9da2ad)});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: RhomboidPainter(color: color),
      size: Size(width, height),
    );
  }
}