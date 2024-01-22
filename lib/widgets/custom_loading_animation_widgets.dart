import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomLoadingAnimation extends StatelessWidget {
  const CustomLoadingAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.dotsTriangle(
      color: Colors.blueAccent.withGreen(200),
      size: 30,
    );
  }
}
