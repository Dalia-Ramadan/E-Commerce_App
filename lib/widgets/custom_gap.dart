import 'package:flutter/material.dart';

class CustomGap extends StatelessWidget {
  final double w;
  final double h;
  const CustomGap({super.key, this.w = 0, this.h = 0});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: w, height: h);
  }
}
