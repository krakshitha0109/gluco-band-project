import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              "assets/doc.jpg", // Make sure it's declared in pubspec.yaml
              fit: BoxFit.cover,
            ),
          ),
          // Overlay
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.3),
            ),
          ),
          // Foreground content
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}