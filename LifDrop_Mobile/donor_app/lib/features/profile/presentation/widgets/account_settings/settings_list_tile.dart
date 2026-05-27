import 'package:donor_app/core/helpers/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_symbols_icons/symbols.dart';

class SettingsListTile extends StatelessWidget {
  const SettingsListTile({
    super.key,
    required this.icon,
    required this.title,
    this.trailing,
    this.onTap,
    this.showDivider = false,
  });

  final IconData icon;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;
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
        ListTile(
          onTap: onTap,
          minVerticalPadding: 20.h,
          leading: Icon(icon, size: 22.sp, color: context.colors.secondary),
          title: Text(title, style: context.textStyles.font16TextPrimaryMedium),
          trailing:
              trailing ??
              Icon(
                Symbols.arrow_forward_ios,
                size: 12.sp,
                color: context.colors.textSecondary.withAlpha(100),
              ),
          splashColor: Colors.white.withAlpha(0),
          hoverColor: Colors.white.withAlpha(0),
        ),
      ],
    );
  }
}
