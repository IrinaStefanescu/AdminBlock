import 'package:flutter/material.dart';

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 680);
    path.quadraticBezierTo(size.width / 8, 400, size.width / 2, 440);
    path.quadraticBezierTo(2 / 3 * size.width, 450, size.width, 300);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
