import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:donor_app/core/mixins/snack_bar_mixin.dart';
import 'package:donor_app/core/routing/routes.dart';
import 'package:donor_app/core/widgets/app_text_button.dart';
import 'package:donor_app/features/auth/presentation/logic/reset_password/reset_password_cubit.dart';
import 'package:donor_app/features/auth/presentation/logic/reset_password/reset_password_state.dart';
import 'package:donor_app/features/auth/presentation/widgets/auth_text_section.dart';
import 'package:donor_app/features/auth/presentation/widgets/password_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({
    super.key,
    required this.email,
    required this.code,
  });
  final String email;
  final String code;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen>
    with SnackBarMixin {
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _newPasswordNotifier = ValueNotifier(true);
  final _confirmPasswordNotifier = ValueNotifier(true);

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _newPasswordNotifier.dispose();
    _confirmPasswordNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {
        if (state.status == ResetPasswordStatus.success) {
          TextInput.finishAutofillContext(shouldSave: true);

          showSuccessSnackBar(
            context,
            message: context.localizations.password_updated_message,
          );
          context.pushNamedAndRemoveUntil(
            Routes.login,
            predicate: (route) => false,
          );
        } else if (state.status == ResetPasswordStatus.failure &&
            state.error != null) {
          showErrorSnackBar(
            context,
            message: state.error!.getAllErrorMessages(),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: AutofillGroup(
                  child: Column(
                    mainAxisAlignment: .center,
                    crossAxisAlignment: .start,
                    children: [
                      AuthTextSection(
                        title: context.localizations.reset_password,
                        titleStyle:
                            context.textStyles.font30TextPrimaryExtraBold,
                        subtitle: context.localizations.reset_subtitle,
                        subtitleStyle:
                            context.textStyles.font14TextPrimaryRegular,
                      ),
                      verticalSpace(32),
                      PasswordSection(
                        notifier: _newPasswordNotifier,
                        controller: _newPasswordController,
                        title: context.localizations.new_password,
                        hintText: '••••••••',
                        autofillHints: const [AutofillHints.newPassword],
                      ),

                      verticalSpace(10),
                      PasswordSection(
                        notifier: _confirmPasswordNotifier,
                        controller: _confirmPasswordController,
                        title: context.localizations.confirm_password,
                        hintText: '••••••••',
                        autofillHints: const [AutofillHints.newPassword],
                      ),
                      verticalSpace(24),
                      AppTextButton(
                        buttonText: context.localizations.update_password,
                        textStyle: context.textStyles.font16TextPrimaryBold,
                        isLoading: state.status == ResetPasswordStatus.loading,
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          if (_newPasswordController.text !=
                              _confirmPasswordController.text) {
                            showErrorSnackBar(
                              context,
                              message:
                                  context.localizations.passwords_do_not_match,
                            );
                            return;
                          }
                          context.read<ResetPasswordCubit>().resetPassword(
                            widget.email,
                            widget.code,
                            _newPasswordController.text,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
