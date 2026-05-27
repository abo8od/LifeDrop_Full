import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:donor_app/core/widgets/app_images.dart';
import 'package:donor_app/core/widgets/app_selection_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThemeCard extends StatelessWidget {
  const ThemeCard({
    super.key,
    required this.title,
    required this.description,
    required this.image,
    required this.icon,
    required this.isSelected,
    required this.iconBackgroundColor,
    required this.onTap,
  });
  final String title;
  final String description;
  final String image;
  final Icon icon;
  final bool isSelected;
  final Color iconBackgroundColor;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? context.colors.navigationBar
              : context.colors.neutral.withAlpha(100),
          borderRadius: BorderRadius.circular(12),
          border: isSelected
              ? Border.all(width: 2, color: context.colors.primary)
              : null,
        ),
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: iconBackgroundColor,
                    shape: BoxShape.circle,
                  ),
                  child: icon,
                ),
                const Spacer(),
                AppSelectionIndicator(isSelected: isSelected),
              ],
            ),
            verticalSpace(20),
            Text(
              title,
              style: context.textStyles.font18TextPrimaryBold.copyWith(
                letterSpacing: 0,
              ),
            ),
            verticalSpace(4),
            Text(
              description,
              style: context.textStyles.font14TextSecondaryRegular.copyWith(
                letterSpacing: 0,
              ),
            ),
            verticalSpace(20),
            AppImages(path: image, type: ImageType.asset),
          ],
        ),
      ),
    );
  }
}
