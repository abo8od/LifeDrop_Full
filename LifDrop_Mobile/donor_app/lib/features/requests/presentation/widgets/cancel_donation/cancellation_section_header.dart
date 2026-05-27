import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:donor_app/core/widgets/app_header.dart';
import 'package:donor_app/features/requests/presentation/widgets/cancel_donation/text_cancel_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CancellationSectionHeader extends StatelessWidget {
  const CancellationSectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => context.pop<bool>(value: false),
          child: AppHeader(
            icon: Icon(
              Icons.arrow_back_ios,
              color: context.colors.secondary,
              size: 20.sp,
            ),
            title: context.localizations.go_back_label,
            style: context.textStyles.font14SecondaryBold.copyWith(
              letterSpacing: 1,
            ),
          ),
        ),
        verticalSpace(2),
        const TextCancelSection(),
      ],
    );
  }
}
