import 'package:donor_app/core/helpers/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerifiedBadge extends StatelessWidget {
  const VerifiedBadge({super.key, required this.isVerified});
  final bool isVerified;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: context.colors.tertiary,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        isVerified
            ? context.localizations.verified_badge
            : context.localizations.unverified_badge,
        style: context.textStyles.font10SecondarySemiBold,
      ),
    );
  }
}
