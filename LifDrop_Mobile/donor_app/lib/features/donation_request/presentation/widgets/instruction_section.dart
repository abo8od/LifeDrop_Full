import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InstructionSection extends StatelessWidget {
  const InstructionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.mode,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: context.colors.primary),
          horizontalSpace(12),
          Text(
            context.localizations.bring_digital_id,
            style: context.textStyles.font14TextPrimaryMedium,
          ),
        ],
      ),
    );
  }
}
