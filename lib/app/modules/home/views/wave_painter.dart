import 'package:flutter/material.dart';

class WavePainter extends CustomPainter {
  Paint circlePaint, wavePaint;
  final double sliderPosition;

  double previoussliderPosition = 0;

  WavePainter({required this.sliderPosition})
      : circlePaint = Paint()..color = Colors.white,
        wavePaint = Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(0.0, size.height), 5, circlePaint);
    canvas.drawCircle(Offset(size.width, size.height), 5, circlePaint);
    Path path = Path();
    double bendWidth = 40;
    path.moveTo(0.0, size.height);
    path.lineTo(sliderPosition - bendWidth / 2, size.height);

    double bendShift=20;
    bool moveLeft = (sliderPosition < previoussliderPosition);
    if (moveLeft) {
      path.quadraticBezierTo(
          sliderPosition-bendShift, 0, sliderPosition + bendWidth / 2, size.height);
    } else {
      path.quadraticBezierTo(
          sliderPosition+bendShift, 0, sliderPosition + bendWidth / 2, size.height);
    }

    path.lineTo(size.width, size.height);
    canvas.drawPath(path, wavePaint);
  }

  @override
  bool shouldRepaint(covariant WavePainter oldDelegate) {
    previoussliderPosition = oldDelegate.sliderPosition;
    return true;
  }
}
