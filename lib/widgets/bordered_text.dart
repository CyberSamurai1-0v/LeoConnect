import 'package:flutter/material.dart';

class BorderedText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color strokeColor;
  final Color fillColor;
  final double strokeWidth;

  const BorderedText({
    super.key,
    required this.text,
    this.fontSize = 20,
    this.strokeColor = Colors.black,
    this.fillColor = Colors.white,
    this.strokeWidth = 3.0,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Stroke
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth
              ..color = strokeColor,
          ),
        ),
        // Fill
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: fillColor,
          ),
        ),
      ],
    );
  }
}