import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:donor_app/core/logic/biometric/biometric_cubit.dart';
import 'package:donor_app/core/logic/biometric/biometric_state.dart';
import 'package:donor_app/features/profile/presentation/widgets/account_settings/settings_toggle_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_symbols_icons/symbols.dart';

class SecurityBentoSection extends StatelessWidget {
  const SecurityBentoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: context.colors.neutral,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          ListTile(
            onTap: () {
              // TODO:: Navigate to Change Password Screen
            },
            splashColor: Colors.transparent,
            leading: Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: context.colors.tertiary,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                Symbols.lock,
                size: 20.sp,
                color: context.colors.secondary,
              ),
            ),
            title: Text(
              context.localizations.change_password,
              style: context.textStyles.font16TextPrimaryMedium,
            ),
            trailing: Icon(
              Symbols.arrow_forward_ios,
              size: 12.sp,
              color: context.colors.textSecondary.withAlpha(100),
            ),
          ),
          verticalSpace(5),
          Divider(
            height: 1,
            thickness: 1,
            color: context.colors.textSecondary.withAlpha(25),
          ),
          BlocBuilder<BiometricCubit, BiometricState>(
            builder: (context, state) {
              return SettingsToggleTile(
                icon: Icons.fingerprint,
                title: context.localizations.enable_fingerprint,
                isSelected: state.isEnabled,
                onChanged: (value) =>
                    context.read<BiometricCubit>().toggle(value),
              );
            },
          ),
        ],
      ),
    );
  }
}
