import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:donor_app/features/profile/presentation/widgets/section_header.dart';
import 'package:donor_app/features/profile/presentation/widgets/account_settings/security_bento_section.dart';
import 'package:flutter/material.dart';

class SecuritySection extends StatelessWidget {
  const SecuritySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: context.localizations.security_access_label),
        verticalSpace(10),
        const SecurityBentoSection(),
      ],
    );
  }
}
