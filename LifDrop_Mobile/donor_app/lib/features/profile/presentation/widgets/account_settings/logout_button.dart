import 'package:donor_app/core/helpers/constants.dart';
import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/shared_pref_helper.dart';
import 'package:donor_app/core/di/injection_container.dart';
import 'package:donor_app/core/routing/routes.dart';
import 'package:donor_app/core/widgets/app_text_button.dart';
import 'package:donor_app/features/notifications/presentation/logic/device_token_cubit.dart';
import 'package:flutter/material.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppTextButton(
      buttonText: context.localizations.logout,
      textStyle: context.textStyles.font16WhiteBold,
      onPressed: () async {
        await getIt<DeviceTokenCubit>().unregisterDeviceToken();
        await SharedPrefHelper.removeAllData();
        await SharedPrefHelper.removeAllSecuredData();

        await SharedPrefHelper.setData(SharedPrefKeys.hasSeenOnboarding, true);

        if (context.mounted) {
          context.pushNamedAndRemoveUntil(
            Routes.login,
            predicate: (route) => false,
          );
        }
      },
    );
  }
}
