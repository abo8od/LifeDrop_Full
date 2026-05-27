import 'package:flutter/material.dart';

class AppSlideFadeAnimation extends StatelessWidget {
  const AppSlideFadeAnimation({
    super.key,
    required this.child,
    required this.delay,
  });
  final Widget child;
  final int delay;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: screenWidth, end: 0),
      duration: Duration(milliseconds: 600 + delay),
      builder: (context, value, childWidget) {
        return Opacity(
          opacity: 1 - (value / screenWidth),
          child: Transform.translate(
            offset: Offset(value, 0),
            child: childWidget,
          ),
        );
      },
      child: child,
    );
  }
}
