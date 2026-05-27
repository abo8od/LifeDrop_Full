import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:donor_app/core/resources/image_paths.dart';
import 'package:donor_app/core/widgets/app_images.dart';
import 'package:donor_app/core/widgets/app_slide_fade_animation.dart';
import 'package:donor_app/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:donor_app/features/auth/presentation/widgets/auth_text_section.dart';
import 'package:donor_app/features/auth/presentation/widgets/password_section.dart';
import 'package:flutter/material.dart';

class RegisterSectionOne extends StatefulWidget {
  const RegisterSectionOne({
    super.key,
    required this.emailController,
    required this.phoneNumberController,
    required this.firstNameController,
    required this.lastNameController,
    required this.passwordController,
    required this.confirmPasswordController,
  });
  final TextEditingController emailController;
  final TextEditingController phoneNumberController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  @override
  State<RegisterSectionOne> createState() => _RegisterSectionOneState();
}

class _RegisterSectionOneState extends State<RegisterSectionOne> {
  final passwordNotifier = ValueNotifier(true);
  final confirmPasswordNotifier = ValueNotifier(true);

  @override
  void dispose() {
    passwordNotifier.dispose();
    confirmPasswordNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        AppSlideFadeAnimation(
          delay: 0,
          child: AuthTextSection(
            title: context.localizations.register,
            subtitle: context.localizations.become_donor,
          ),
        ),
        verticalSpace(35),
        AppSlideFadeAnimation(
          delay: 100,
          child: AuthTextField(
            controller: widget.firstNameController,
            hintText: context.localizations.first_name,
            title: context.localizations.first_name,
            prefixIcon: const Icon(Icons.person_outline),
          ),
        ),
        verticalSpace(10),
        AppSlideFadeAnimation(
          delay: 150,
          child: AuthTextField(
            controller: widget.lastNameController,
            hintText: context.localizations.last_name,
            title: context.localizations.last_name,
            prefixIcon: const Icon(Icons.person_outline),
          ),
        ),
        verticalSpace(10),
        AppSlideFadeAnimation(
          delay: 200,
          child: AuthTextField(
            controller: widget.emailController,
            title: context.localizations.email,
            hintText: 'donor@pulse.com',
            keyboardType: TextInputType.emailAddress,
            prefixIcon: AppImages(
              path: ImagePaths.atSign,
              type: ImageType.svg,
              color: context.colors.textPlaceHolder,
            ),
          ),
        ),
        verticalSpace(10),
        AppSlideFadeAnimation(
          delay: 250,
          child: AuthTextField(
            controller: widget.phoneNumberController,
            hintText: '7XXXXXXXX',
            title: context.localizations.phone_number,
            keyboardType: TextInputType.phone,
            prefixIcon: Row(
              children: [
                Icon(
                  Icons.phone_outlined,
                  color: context.colors.textPlaceHolder,
                ),
                horizontalSpace(5),
                Text(
                  '+962',
                  style: context.textStyles.font16TextPlaceHolderMedium50Faded,
                ),
              ],
            ),
          ),
        ),
        verticalSpace(10),
        AppSlideFadeAnimation(
          delay: 300,
          child: PasswordSection(
            notifier: passwordNotifier,
            controller: widget.passwordController,
            title: context.localizations.password,
            hintText: '••••••••',
          ),
        ),
        verticalSpace(10),
        AppSlideFadeAnimation(
          delay: 350,
          child: PasswordSection(
            notifier: confirmPasswordNotifier,
            controller: widget.confirmPasswordController,
            title: context.localizations.confirm_password,
            hintText: '••••••••',
          ),
        ),
      ],
    );
  }
}
