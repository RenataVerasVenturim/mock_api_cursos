import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class CustomProgressDisplay extends StatelessWidget {
  const CustomProgressDisplay(
      {super.key, this.height = 50.0, this.brightMode = false});

  final double height;
  final bool brightMode;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: RiveAnimation.asset(
        brightMode
            ? "assets/animations/logo_uff_animado_white.riv"
            : "assets/animations/logo_uff_animado.riv",
        alignment: Alignment.center,
      ),
    );
  }
}
