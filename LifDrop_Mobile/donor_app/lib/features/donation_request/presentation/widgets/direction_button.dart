import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DirectionButton extends StatelessWidget {
  const DirectionButton({super.key, required this.onTap});
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: .end,
          children: [
            Text(
              context.localizations.got_to_map,
              style: context.textStyles.font14PrimaryBold,
            ),
            horizontalSpace(4),
            Icon(
              Icons.open_in_new_outlined,
              color: context.colors.primary,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
