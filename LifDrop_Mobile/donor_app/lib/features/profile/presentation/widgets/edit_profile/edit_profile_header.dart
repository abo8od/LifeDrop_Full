import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/widgets/app_header.dart';
import 'package:flutter/material.dart';

class EditProfileHeader extends StatelessWidget {
  const EditProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return AppHeader(
      icon: GestureDetector(
        onTap: () => context.pop<bool>(value: false),
        child: Icon(Icons.arrow_back, color: context.colors.textPrimary),
      ),
      title: context.localizations.edit_profile_title,
      style: context.textStyles.font20TextPrimaryBold.copyWith(
        letterSpacing: -0.5,
      ),
    );
  }
}
