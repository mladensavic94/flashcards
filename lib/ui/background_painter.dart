import 'package:flutter/material.dart';

class BackgroundPainter extends CustomPainter{
  final Color color;
  BackgroundPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
    ..color = color
    ..strokeWidth = 1
    ..style = PaintingStyle.fill;
    var path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.7);
    path.quadraticBezierTo(size.width * 0.95 , size.height * 0.9, size.width * 0.5 , size.height);
    path.quadraticBezierTo(size.width *0.05, size.height*1.1, 0, size.height*1.3);
    path.lineTo(0, size.height * 1.3);
    path.lineTo(0,0);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }


}