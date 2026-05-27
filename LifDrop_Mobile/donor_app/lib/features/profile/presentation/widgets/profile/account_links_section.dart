import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/routing/routes.dart';
import 'package:donor_app/features/profile/domain/entities/user_entity.dart';
import 'package:donor_app/features/profile/presentation/logic/profile/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_symbols_icons/symbols.dart';

class AccountLinksSection extends StatelessWidget {
  const AccountLinksSection({super.key, this.user});
  final UserEntity? user;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.neutral,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(8.w),
      child: Column(
        children: [
          ListTile(
            leading: Icon(
              Icons.settings_outlined,
              color: context.colors.secondary,
            ),
            title: Text(
              context.localizations.account_settings_title,
              style: context.textStyles.font16TextPrimaryMedium,
            ),
            trailing: Icon(
              Symbols.arrow_forward_ios,
              color: context.colors.primary.withAlpha(50),
              size: 20,
            ),
            onTap: () {
              context.pushNamed(
                Routes.accountSettings,
                arguments: {
                  'user': user,
                  'profileCubit': context.read<ProfileCubit>(),
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
