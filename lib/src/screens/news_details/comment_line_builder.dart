import 'package:flutter/material.dart';

class CommentLineBuilder extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    /// creates a paint with following config
    Paint _paint = Paint()..color = Colors.black54;
    _paint.strokeWidth = 1;

    /// simply draws a line at the left of the child
    canvas.drawLine(Offset(-10, 0), Offset(-10, size.height), _paint);
  }

  /// there's no need to repaint the painter, so returning false
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
