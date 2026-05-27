import 'dart:async';

import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:donor_app/core/mixins/snack_bar_mixin.dart';
import 'package:donor_app/core/routing/routes.dart';
import 'package:donor_app/core/widgets/app_text_button.dart';
import 'package:donor_app/features/auth/presentation/logic/otp/otp_cubit.dart';
import 'package:donor_app/features/auth/presentation/logic/otp/otp_state.dart';
import 'package:donor_app/features/auth/presentation/widgets/auth_switch_section.dart';
import 'package:donor_app/features/auth/presentation/widgets/auth_text_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPVerificationScreen extends StatefulWidget {
  const OTPVerificationScreen({
    super.key,
    required this.email,
    this.isFromRegister = true,
  });
  final String email;
  final bool isFromRegister;

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen>
    with SnackBarMixin {
  final _pinController = PinInputController();
  final _timerNotifier = ValueNotifier(60);
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerNotifier.value == 0) {
        timer.cancel();
      } else {
        _timerNotifier.value--;
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pinController.dispose();
    _timerNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OtpCubit, OtpState>(
      listener: (context, state) {
        if (state.status == OtpStatus.verified) {
          if (widget.isFromRegister) {
            showSuccessSnackBar(
              context,
              message: context.localizations.account_acreated_message,
            );
            context.pushNamedAndRemoveUntil(
              Routes.login,
              predicate: (route) => false,
            );
          } else {
            context.pushNamed(
              Routes.resetPassword,
              arguments: {'email': widget.email, 'code': _pinController.text},
            );
          }
        } else if (state.status == OtpStatus.failure && state.error != null) {
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
                child: Column(
                  mainAxisAlignment: .center,
                  crossAxisAlignment: .start,
                  children: [
                    AuthTextSection(
                      title: context.localizations.otp_verification,
                      titleStyle: context.textStyles.font30TextPrimaryExtraBold,
                      subtitle: widget.isFromRegister
                          ? context.localizations.otp_from_register_subtitle
                          : context
                                .localizations
                                .otp_from_forgot_password_subtitle,
                      subtitleStyle:
                          context.textStyles.font14TextPrimaryRegular,
                    ),
                    verticalSpace(32),
                    MaterialPinField(
                      length: 6,
                      pinController: _pinController,
                      onCompleted: (pin) => _verifyOtp(context, pin),
                      theme: MaterialPinTheme(
                        shape: MaterialPinShape.outlined,
                        filledFillColor: context.colors.surface,
                        focusedFillColor: context.colors.secondary.withAlpha(
                          100,
                        ),
                        focusedBorderColor: context.colors.secondary,
                        cursorColor: context.colors.textPrimary,
                        cellSize: const Size(45, 64),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    verticalSpace(24),
                    AppTextButton(
                      buttonText: context.localizations.verify_continue,
                      textStyle: context.textStyles.font16TextPrimaryBold,
                      isLoading: state.status == OtpStatus.loading,
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        if (_pinController.text.length == 6) {
                          _verifyOtp(context, _pinController.text);
                        }
                      },
                    ),
                    verticalSpace(30),
                    ValueListenableBuilder(
                      valueListenable: _timerNotifier,
                      builder: (context, value, child) {
                        final min = (value ~/ 60).toString().padLeft(2, '0');
                        final sec = (value % 60).toString().padLeft(2, '0');
                        return AuthSwitchSection(
                          text: context.localizations.didnt_receive_code,
                          actionText: value > 0
                              ? '${context.localizations.resend_timer}: $min:$sec'
                              : context.localizations.resend_again,
                          onTap: () {
                            if (value == 0) {
                              _timerNotifier.value = 60;
                              _startTimer();

                              showSuccessSnackBar(
                                context,
                                message:
                                    context.localizations.resend_code_message,
                              );
                              _resendOtp(context);
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _verifyOtp(BuildContext context, String otp) {
    if (widget.isFromRegister) {
      context.read<OtpCubit>().verifyRegistration(widget.email, otp);
    } else {
      context.read<OtpCubit>().verifyOtp(widget.email, otp);
    }
  }

  void _resendOtp(BuildContext context) {
    if (widget.isFromRegister) {
      context.read<OtpCubit>().resendRegistrationOtp(widget.email);
    } else {
      context.read<OtpCubit>().resendOtp(widget.email);
    }
  }
}
