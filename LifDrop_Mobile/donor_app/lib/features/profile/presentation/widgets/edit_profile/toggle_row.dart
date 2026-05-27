import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:donor_app/core/widgets/custom_toggle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ToggleRow extends StatelessWidget {
  const ToggleRow({
    super.key,
    required this.icon,
    required this.notifier,
    required this.title,
  });
  final IconData icon;
  final String title;
  final ValueNotifier<bool> notifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: notifier,
      builder: (context, isSelected, _) {
        return Row(
          children: [
            Icon(
              icon,
              color: isSelected
                  ? context.colors.primary
                  : context.colors.textSecondary,
              size: 24.sp,
            ),
            horizontalSpace(12),
            Expanded(
              child: Text(
                title,
                style: context.textStyles.font14TextPrimarySemiBold,
              ),
            ),
            CustomToggle(
              isSelected: isSelected,
              onChanged: (value) => notifier.value = value,
              activeColor: context.colors.primary,
            ),
          ],
        );
      },
    );
  }
}
