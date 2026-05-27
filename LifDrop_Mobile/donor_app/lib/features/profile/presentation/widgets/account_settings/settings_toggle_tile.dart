import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:donor_app/core/widgets/custom_toggle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsToggleTile extends StatelessWidget {
  const SettingsToggleTile({
    super.key,
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.onChanged,
    this.showDivider = false,
  });

  final IconData icon;
  final String title;
  final bool isSelected;
  final ValueChanged<bool> onChanged;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showDivider)
          Divider(
            height: 1,
            thickness: 1,
            color: context.colors.textSecondary.withAlpha(25),
          ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Row(
            children: [
              Icon(icon, size: 20.sp, color: context.colors.secondary),
              horizontalSpace(16),
              Expanded(
                child: Text(
                  title,
                  style: context.textStyles.font16TextPrimaryMedium,
                ),
              ),
              CustomToggle(
                isSelected: isSelected,
                onChanged: onChanged,
                activeColor: context.colors.primary,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
