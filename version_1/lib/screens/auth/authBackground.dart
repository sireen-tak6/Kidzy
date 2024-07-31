import 'package:flutter/material.dart';

class authBackground extends StatelessWidget {
  late Size screen;
  authBackground(screensize) {
    this.screen = screensize;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(color: Colors.white),
          width: screen.width,
          height: screen.height,
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Image.asset(
            "5240457-01-01-01.png",
            width: screen.width * 0.8,
            color: Colors.white.withOpacity(0.6),
            colorBlendMode: BlendMode.modulate,
            alignment: Alignment.topLeft,
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Image.asset(
            "Untitled-1-01.png",
            fit: BoxFit.fitWidth,
            width: screen.width,
          ),
        )
      ],
    );
  }
}
