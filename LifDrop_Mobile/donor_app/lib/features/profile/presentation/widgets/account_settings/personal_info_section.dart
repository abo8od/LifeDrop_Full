import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:donor_app/core/routing/routes.dart';
import 'package:donor_app/features/profile/domain/entities/user_entity.dart';
import 'package:donor_app/features/profile/presentation/logic/profile/profile_cubit.dart';
import 'package:donor_app/features/profile/presentation/widgets/section_header.dart';
import 'package:donor_app/features/profile/presentation/widgets/account_settings/settings_list_tile.dart';
import 'package:donor_app/features/profile/presentation/widgets/account_settings/verified_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';

class PersonalInfoSection extends StatelessWidget {
  const PersonalInfoSection({super.key, required this.user});
  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: context.localizations.personal_information_label),
        verticalSpace(10),
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: context.colors.neutral,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              SettingsListTile(
                icon: Symbols.person_edit,
                title: context.localizations.edit_profile,
                onTap: () async {
                  final bool value = await context.pushNamed(
                    Routes.editProfile,
                    arguments: user,
                  );

                  if (context.mounted && value) {
                    context.read<ProfileCubit>().getUserProfile();
                  }
                },
              ),
              SettingsListTile(
                icon: Symbols.verified_user,
                title: context.localizations.verification_status,
                showDivider: true,
                trailing: VerifiedBadge(isVerified: user.isMedicallyVerified),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
