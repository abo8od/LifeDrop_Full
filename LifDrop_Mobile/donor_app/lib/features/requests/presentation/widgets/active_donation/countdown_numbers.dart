import 'package:donor_app/core/helpers/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CountdownNumbers extends StatelessWidget {
  const CountdownNumbers({
    super.key,
    required this.hours,
    required this.minutes,
    required this.seconds,
  });
  final int hours;
  final int minutes;
  final int seconds;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _CountdownUnit(
          value: hours.toString().padLeft(2, '0'),
          label: context.localizations.hours_abbreviation,
        ),
        _ColonSeparator(),
        _CountdownUnit(
          value: minutes.toString().padLeft(2, '0'),
          label: context.localizations.minutes_abbreviation,
        ),
        _ColonSeparator(),
        _CountdownUnit(
          value: seconds.toString().padLeft(2, '0'),
          label: context.localizations.seconds_abbreviation,
        ),
      ],
    );
  }
}

class _CountdownUnit extends StatelessWidget {
  const _CountdownUnit({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: context.textStyles.font48PrimaryExtraBold),
        Text(
          label,
          style: context.textStyles.font10TextSecondaryRegular.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
            color: context.colors.textSecondary,
          ),
        ),
      ],
    );
  }
}

class _ColonSeparator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.h, left: 8.w, right: 8.w),
      child: Text(
        ':',
        style: context.textStyles.font36TextPrimaryExtraBold.copyWith(
          color: context.colors.primary.withAlpha(70),
        ),
      ),
    );
  }
}
