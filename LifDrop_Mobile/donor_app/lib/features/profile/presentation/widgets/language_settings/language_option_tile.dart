import 'package:donor_app/core/helpers/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LanguageOptionTile extends StatelessWidget {
  const LanguageOptionTile({
    super.key,
    required this.flag,
    required this.nativeName,
    required this.localizedName,
    required this.isSelected,
    required this.onTap,
    this.showDivider = false,
  });

  final String flag;
  final String nativeName;
  final String localizedName;
  final bool isSelected;
  final VoidCallback onTap;
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
          leading: Text(flag, style: TextStyle(fontSize: 24.sp)),
          title: Text(
            nativeName,
            style: context.textStyles.font16TextPrimaryMedium,
          ),
          subtitle: Text(
            localizedName,
            style: context.textStyles.font12TextSecondaryRegular,
          ),
          trailing: Container(
            width: 20.w,
            height: 20.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected
                    ? context.colors.primary
                    : context.colors.textSecondary.withAlpha(80),
                width: isSelected ? 6.w : 1.5.w,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
