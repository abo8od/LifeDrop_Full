import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:flutter/material.dart';

class PasswordSection extends StatelessWidget {
  const PasswordSection({
    super.key,
    required this.notifier,
    required this.controller,
    required this.title,
    required this.hintText,
    this.autofillHints,
  });
  final ValueNotifier<bool> notifier;
  final TextEditingController controller;
  final String title;
  final String hintText;
  final Iterable<String>? autofillHints;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: notifier,
      builder: (context, value, child) {
        return AuthTextField(
          autofillHints: autofillHints,
          obscureText: value,
          controller: controller,
          title: title,
          hintText: hintText,
          keyboardType: TextInputType.visiblePassword,
          prefixIcon: Icon(
            Icons.lock_outlined,
            color: context.colors.textPlaceHolder,
          ),
          suffixIcon: GestureDetector(
            onTap: () => notifier.value = !notifier.value,
            child: Icon(
              value ? Icons.visibility_outlined : Icons.visibility_off_outlined,
              color: context.colors.textPlaceHolder,
            ),
          ),
        );
      },
    );
  }
}
