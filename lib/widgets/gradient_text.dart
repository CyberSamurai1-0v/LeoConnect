import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  final String text;
  final Gradient gradient;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign? textAlign;

  const GradientText(
    this.text, {
    super.key,
    required this.gradient,
    this.fontSize = 24.0,
    this.fontWeight = FontWeight.w900,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
        textAlign: textAlign,
      ),
    );
  }
}
