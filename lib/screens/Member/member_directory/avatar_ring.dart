import 'package:flutter/material.dart';

class AvatarWithRing extends StatelessWidget {
  final String imageUrl;
  final Color ringColor;
  final double size;
  const AvatarWithRing({
    super.key,
    required this.imageUrl,
    // ignore: unused_element_parameter
    this.ringColor = Colors.yellow,
    this.size = 56,
  });

  @override
  Widget build(BuildContext context) {
    final ring = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            ringColor.withValues(alpha: 0.95),
            ringColor.withValues(alpha: 0.60),
          ],
        ),
      ),
    );

    return Stack(
      alignment: Alignment.center,
      children: [
        ring,
        Container(
          width: size - 8,
          height: size - 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[850],
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
              onError: (error, stackTrace) {
                // Ignore
              },
            ),
          ),
        ),
      ],
    );
  }
}
