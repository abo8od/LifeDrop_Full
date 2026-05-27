import 'package:donor_app/core/helpers/spacing.dart';
import 'package:donor_app/features/onboarding/widgets/onboarding_image.dart';
import 'package:donor_app/features/onboarding/widgets/onboarding_text_content.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.index,
  });
  final String image;
  final String title;
  final String subtitle;
  final int index;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: Column(
        key: ValueKey(index),
        children: [
          verticalSpace(20),
          OnboardingImage(image: image),
          verticalSpace(38),
          OnboardingTextContent(title: title, subtitle: subtitle, index: index),
        ],
      ),
    );
  }
}
