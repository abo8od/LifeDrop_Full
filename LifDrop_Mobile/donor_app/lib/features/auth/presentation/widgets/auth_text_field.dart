import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.hintText,
    required this.title,
    this.hintTextStyle,
    this.titleStyle,
    required this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.autofillHints = const [],
  });
  final String hintText;
  final String title;
  final TextStyle? hintTextStyle;
  final TextStyle? titleStyle;
  final Widget prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final Iterable<String>? autofillHints;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          title,
          style: titleStyle ?? context.textStyles.font12SecondaryBold,
        ),
        verticalSpace(8),
        TextField(
          obscureText: obscureText,
          controller: controller,
          keyboardType: keyboardType,
          autofillHints: autofillHints,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle:
                hintTextStyle ??
                context.textStyles.font16TextPlaceHolderMedium50Faded,
            suffixIcon: suffixIcon != null
                ? Padding(
                    padding: EdgeInsets.only(right: 12.w, left: 10.w),
                    child: suffixIcon,
                  )
                : null,
            prefixIcon: Padding(
              padding: EdgeInsets.only(right: 10.w, left: 12.w),
              child: prefixIcon,
            ),
          ),
        ),
      ],
    );
  }
}
