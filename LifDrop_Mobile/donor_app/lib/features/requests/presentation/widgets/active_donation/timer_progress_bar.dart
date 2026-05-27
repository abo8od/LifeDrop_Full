import 'package:donor_app/core/helpers/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimerProgressBar extends StatelessWidget {
  const TimerProgressBar({super.key, required this.progress});
  final double progress;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: SizedBox(
        height: 6.h,
        width: double.infinity,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFE5E8ED),
                borderRadius: BorderRadius.circular(9999),
              ),
            ),
            AnimatedFractionallySizedBox(
              duration: const Duration(milliseconds: 500),
              widthFactor: progress,
              child: Container(
                decoration: BoxDecoration(
                  color: context.colors.primary,
                  // shape: .circle,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: context.colors.primary.withAlpha(102),
                      blurRadius: 12,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
