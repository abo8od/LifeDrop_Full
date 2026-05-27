import 'package:donor_app/core/helpers/biometric_helper.dart';
import 'package:donor_app/core/helpers/constants.dart';
import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/shared_pref_helper.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:donor_app/core/mixins/snack_bar_mixin.dart';
import 'package:donor_app/core/routing/routes.dart';
import 'package:donor_app/core/widgets/app_text_button.dart';
import 'package:donor_app/features/auth/presentation/logic/login/login_cubit.dart';
import 'package:donor_app/features/auth/presentation/logic/login/login_state.dart';
import 'package:donor_app/features/auth/presentation/widgets/login_form_section.dart';
import 'package:donor_app/features/auth/presentation/widgets/auth_switch_section.dart';
import 'package:donor_app/features/auth/presentation/widgets/auth_text_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SnackBarMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _biometricLogin() async {
    final isEnabled = await SharedPrefHelper.getBool(
      SharedPrefKeys.biometricEnabled,
    );
    final isTokensSaved = await SharedPrefHelper.getSecuredString(
      SharedPrefKeys.accessToken,
    );
    if (!isEnabled || isTokensSaved.isEmpty) return;

    final success = await BiometricHelper().authenticate(
      context.localizations.authenticate_to_login,
    );

    if (success) {
      if (mounted) context.pushReplacementNamed(Routes.mainNavigation);
    }
  }

  @override
  void initState() {
    super.initState();
    _biometricLogin();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.success) {
          TextInput.finishAutofillContext();
          context.pushNamedAndRemoveUntil(
            Routes.mainNavigation,
            predicate: (route) => false,
          );
        } else if (state.status == LoginStatus.failure && state.error != null) {
          showErrorSnackBar(
            context,
            message:
                state.error?.getAllErrorMessages() ?? 'Something went wrong',
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            behavior: HitTestBehavior.opaque,
            child: SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        mainAxisAlignment: .center,
                        crossAxisAlignment: .start,
                        children: [
                          AuthTextSection(
                            title: context.localizations.login,
                            subtitle: context.localizations.welcome_back,
                          ),
                          verticalSpace(48),
                          LoginFormSection(
                            emailController: _emailController,
                            passwordController: _passwordController,
                          ),
                          verticalSpace(40),
                          AppTextButton(
                            buttonText: context.localizations.login,
                            textStyle: context.textStyles.font16TextPrimaryBold,
                            isLoading: state.status == LoginStatus.loading,
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              final email = _emailController.text.trim();
                              final password = _passwordController.text.trim();

                              if (email.isNotEmpty && password.isNotEmpty) {
                                context.read<LoginCubit>().login(
                                  _emailController.text.trim(),
                                  _passwordController.text.trim(),
                                );
                              }
                            },
                          ),
                          verticalSpace(15),
                          AuthSwitchSection(
                            text: context.localizations.new_donor,
                            actionText: context.localizations.register_now,
                            onTap: () => context.pushNamed(Routes.register),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
