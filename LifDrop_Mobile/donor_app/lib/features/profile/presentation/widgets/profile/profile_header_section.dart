import 'package:donor_app/core/enums/blood_type.dart';
import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:donor_app/core/widgets/box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class ProfileHeaderSection extends StatelessWidget {
  const ProfileHeaderSection({
    super.key,
    required this.isVerified,
    required this.firstName,
    required this.lastName,
    required this.districtName,
    required this.governorateName,
    required this.bloodType,
  });
  final String? firstName;
  final String? lastName;
  final String? governorateName;
  final String? districtName;
  final BloodType? bloodType;
  final bool? isVerified;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: context.colors.primary.withAlpha(
              context.isDarkMode ? 100 : 50,
            ),
            shape: BoxShape.circle,
          ),
          padding: EdgeInsets.all(30.w),
          child: Center(
            child: Text(
              bloodType!.label,
              style: context.textStyles.font36PrimaryExtraBold,
            ),
          ),
        ),
        horizontalSpace(24),
        Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              '$firstName $lastName',
              style: context.textStyles.font24TextPrimaryExtraBold.copyWith(
                letterSpacing: 0,
              ),
            ),
            verticalSpace(4),
            Text('$governorateName, $districtName'),
            verticalSpace(4),
            Row(
              children: [
                TwoToneIcon.varied(
                  isVerified! ? Symbols.verified : Symbols.verified_off,
                  size: 16,
                  color: context.colors.background,
                  color2: context.colors.secondary,
                ),
                horizontalSpace(4),
                Text(
                  isVerified!
                      ? context.localizations.verified_donor
                      : context.localizations.unverified_donor,
                  style: context.textStyles.font12SecondarySemiBold.copyWith(
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
