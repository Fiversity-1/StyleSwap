//Code used from Clipper Widget Flutter - Medium
import 'package:flutter/material.dart';

class OvalShapeClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    final width = size.width;
    final height = size.height;
    Rect rect = Rect.fromLTWH(0, 0, width, height);

    return rect;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return false;
  }
}
