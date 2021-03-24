import 'package:flutter/material.dart';

class CommentLineBuilder extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint _paint = Paint()..color = Colors.black54;
    _paint.strokeWidth = 1;
    canvas.drawLine(Offset(-10, 0), Offset(-10, size.height), _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
