import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:donor_app/features/profile/presentation/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_symbols_icons/symbols.dart';

class CurrentLanguageCard extends StatelessWidget {
  const CurrentLanguageCard({
    super.key,
    required this.languageName,
    required this.flag,
  });

  final String languageName;
  final String flag;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        SectionHeader(title: context.localizations.current_language_label),
        verticalSpace(10),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 8.h),
          decoration: BoxDecoration(
            color: context.colors.neutral,
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: Text(flag, style: TextStyle(fontSize: 24.sp)),
            title: Text(
              languageName,
              style: context.textStyles.font16TextPrimaryBold,
            ),
            trailing: Icon(
              Symbols.check_circle_rounded,
              size: 22.sp,
              color: context.colors.primary,
              fill: 1,
            ),
          ),
        ),
      ],
    );
  }
}
