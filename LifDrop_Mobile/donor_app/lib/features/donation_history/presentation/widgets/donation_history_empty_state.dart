import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:donor_app/core/resources/image_paths.dart';
import 'package:donor_app/core/widgets/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DonationHistoryEmptyState extends StatelessWidget {
  const DonationHistoryEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64.w,
              height: 64.w,
              decoration: BoxDecoration(
                color: context.colors.iconActiveBackground.withAlpha(120),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: AppImages(
                path: ImagePaths.historyIcon,
                type: ImageType.svg,
                color: context.colors.primary,
                width: 24,
                height: 24,
              ),
            ),
            verticalSpace(18),
            Text(
              'No donation history yet',
              textAlign: TextAlign.center,
              style: context.textStyles.font18TextPrimaryBold,
            ),
            verticalSpace(8),
            Text(
              'Your completed and cancelled donation responses will appear here.',
              textAlign: TextAlign.center,
              style: context.textStyles.font14TextPlaceHolderRegular,
            ),
          ],
        ),
      ),
    );
  }
}
