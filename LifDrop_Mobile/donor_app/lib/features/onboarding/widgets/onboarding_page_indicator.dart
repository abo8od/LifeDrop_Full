import 'package:donor_app/core/helpers/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingPageIndicator extends StatelessWidget {
  const OnboardingPageIndicator({super.key, required this.currentIndex});
  final int currentIndex;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          height: 6.h,
          width: currentIndex == index ? 32.w : 8.w,
          decoration: BoxDecoration(
            color: currentIndex == index
                ? context.colors.primary
                : context.colors.surface,
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
