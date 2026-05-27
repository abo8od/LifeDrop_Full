import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:donor_app/core/resources/image_paths.dart';
import 'package:donor_app/core/widgets/app_images.dart';
import 'package:flutter/material.dart';

class OnboardingHeader extends StatelessWidget {
  const OnboardingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppImages(
          path: ImagePaths.logo,
          type: ImageType.svg,
          color: context.colors.primary,
        ),
        horizontalSpace(8),
        Text(
          context.localizations.pulse,
          style: context.textStyles.font24TextPrimaryBold,
        ),
      ],
    );
  }
}
