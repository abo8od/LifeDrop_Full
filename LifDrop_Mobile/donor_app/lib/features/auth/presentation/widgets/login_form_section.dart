import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:donor_app/core/resources/image_paths.dart';
import 'package:donor_app/core/routing/routes.dart';
import 'package:donor_app/core/widgets/app_images.dart';
import 'package:donor_app/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:donor_app/features/auth/presentation/widgets/password_section.dart';
import 'package:flutter/material.dart';

class LoginFormSection extends StatefulWidget {
  const LoginFormSection({
    super.key,
    required this.emailController,
    required this.passwordController,
  });
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  State<LoginFormSection> createState() => _LoginFormSectionState();
}

class _LoginFormSectionState extends State<LoginFormSection> {
  final passwordNotifier = ValueNotifier(true);

  @override
  void dispose() {
    passwordNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AutofillGroup(
      child: Column(
        crossAxisAlignment: .start,
        children: [
          AuthTextField(
            autofillHints: const [AutofillHints.email],
            controller: widget.emailController,
            title: context.localizations.email,
            titleStyle: context.textStyles.font12SecondaryBold,
            hintText: 'donor@pulse.com',
            keyboardType: TextInputType.emailAddress,
            prefixIcon: AppImages(
              path: ImagePaths.atSign,
              type: ImageType.svg,
              color: context.colors.textPlaceHolder,
            ),
            hintTextStyle:
                context.textStyles.font16TextPlaceHolderMedium50Faded,
            // onTap: _autoFillFields,
          ),
          verticalSpace(24),
          PasswordSection(
            autofillHints: const [AutofillHints.password],
            notifier: passwordNotifier,
            controller: widget.passwordController,
            title: context.localizations.password,
            hintText: '••••••••',
          ),
          verticalSpace(12),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                context.pushNamed(Routes.forgotPassword);
              },
              child: Text(
                context.localizations.forgot_password,
                style: context.textStyles.font12SecondarySemiBold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
