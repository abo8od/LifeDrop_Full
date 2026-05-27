import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/resources/image_paths.dart';
import 'package:donor_app/core/widgets/app_images.dart';
import 'package:flutter/material.dart';

class SplashLogoCircle extends StatelessWidget {
  const SplashLogoCircle({super.key});

  @override
  Widget build(BuildContext context) {
    // circle container with full radius and background color white with size 128 x 128 and center it in the screen and contain an image of the app logo in the center of the container with size 64 x 64

    return Container(
      width: 128,
      height: 128,
      decoration: BoxDecoration(
        color: context.colors.mode,
        shape: BoxShape.circle,
        boxShadow: [
          // add radius to the shadow with 16 and color with primary color with blur
          BoxShadow(
            color: context.isDarkMode
                ? context.colors.primary.withAlpha(50)
                : context.colors.surface.withAlpha(50),
            blurRadius: 50,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Center(
        child: AppImages(
          path: context.isDarkMode
              ? ImagePaths.splashLogoDark
              : ImagePaths.splashLogoLight,
          type: ImageType.svg,
        ),
      ),
    );
  }
}
