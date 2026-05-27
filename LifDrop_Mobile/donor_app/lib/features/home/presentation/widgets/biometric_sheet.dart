import 'package:donor_app/core/di/injection_container.dart';
import 'package:donor_app/core/helpers/biometric_helper.dart';
import 'package:donor_app/core/helpers/constants.dart';
import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/shared_pref_helper.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:flutter/material.dart';

class BiometricSheet extends StatelessWidget {
  const BiometricSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsGeometry.all(20),
      child: Column(
        mainAxisSize: .min,
        children: [
          const Icon(Icons.fingerprint, size: 60),
          verticalSpace(16),
          Text(
            context.localizations.quick_login,
            style: context.textStyles.font20TextPrimaryBold,
          ),
          verticalSpace(10),
          Text(
            context.localizations.enable_biometric_login_message,
            style: context.textStyles.font15TextPrimaryRegular,
            textAlign: TextAlign.center,
          ),
          verticalSpace(20),
          Row(
            mainAxisAlignment: .end,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.colors.primary,
                ),
                onPressed: () async {
                  final success = await getIt<BiometricHelper>().authenticate(
                    context
                        .localizations
                        .use_fingerprint_for_quick_secure_login,
                  );
                  if (success) {
                    await SharedPrefHelper.setData(
                      SharedPrefKeys.biometricEnabled,
                      true,
                    );
                    await SharedPrefHelper.setData(
                      SharedPrefKeys.biometricPromptShown,
                      true,
                    );
                    if (context.mounted) context.pop();
                  }
                },
                child: Text(
                  context.localizations.enable,
                  style: context.textStyles.font14TextPrimaryMedium,
                ),
              ),
              horizontalSpace(5),
              TextButton(
                onPressed: () async {
                  await SharedPrefHelper.setData(
                    SharedPrefKeys.biometricEnabled,
                    false,
                  );
                  await SharedPrefHelper.setData(
                    SharedPrefKeys.biometricPromptShown,
                    true,
                  );
                  if (context.mounted) context.pop();
                },
                child: Text(
                  context.localizations.skip,
                  style: context.textStyles.font14TextPrimaryMedium,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
