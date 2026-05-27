import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/widgets/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingImage extends StatelessWidget {
  const OnboardingImage({super.key, required this.image});
  final String image;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentGeometry.center,
      children: [
        Container(
          width: 260.w,
          height: 260.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: context.isDarkMode
                    ? context.colors.primary.withAlpha(51)
                    : context.colors.iconActiveBackground.withAlpha(51),
                blurRadius: 30,
                offset: const Offset(0, 0),
              ),
            ],
          ),
        ),
        AppImages(path: image, type: ImageType.asset, width: 256, height: 256),
      ],
    );
  }
}
