import 'dart:async';

import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:donor_app/features/requests/presentation/widgets/active_donation/countdown_numbers.dart';
import 'package:donor_app/features/requests/presentation/widgets/active_donation/timer_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExpirationCountdownCard extends StatefulWidget {
  const ExpirationCountdownCard({super.key, required this.acceptedAt});
  final DateTime acceptedAt;

  @override
  State<ExpirationCountdownCard> createState() =>
      _ExpirationCountdownCardState();
}

class _ExpirationCountdownCardState extends State<ExpirationCountdownCard> {
  // total minutes 120 because donation request expires 2 hours after acceptance.
  final int _totalSeconds = 120 * 60;
  late Timer _timer;
  late int _remainingSeconds;
  late DateTime _expiresAt;

  int get _hours => _remainingSeconds ~/ 3600;
  int get _minutes => (_remainingSeconds % 3600) ~/ 60;
  int get _seconds => _remainingSeconds % 60;
  double get _progress =>
      _totalSeconds > 0 ? _remainingSeconds / _totalSeconds : 0;
  bool get _isExpired => _remainingSeconds <= 0;

  int _calcRemaining() {
    final diff = _expiresAt.difference(DateTime.now().toUtc()).inSeconds;
    return diff < 0 ? 0 : diff;
  }

  @override
  void initState() {
    super.initState();
    _expiresAt = widget.acceptedAt.add(Duration(seconds: _totalSeconds));
    _remainingSeconds = _calcRemaining();

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final remaining = _calcRemaining();
      setState(() {
        _remainingSeconds = remaining;
      });
      if (remaining == 0) {
        _timer.cancel();
        context.pop<bool>(value: true);
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(33.w),
      decoration: BoxDecoration(
        color: context.colors.mode,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE4BEBC).withAlpha(38)),
      ),
      child: Column(
        children: [
          Text(
            _isExpired
                ? context.localizations.request_expired_heading
                : context.localizations.request_expires_in_heading,
            style: context.textStyles.font10TextSecondaryRegular.copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
              color: context.colors.textSecondary,
            ),
          ),
          verticalSpace(16),
          CountdownNumbers(hours: _hours, minutes: _minutes, seconds: _seconds),
          verticalSpace(16),
          TimerProgressBar(progress: _progress),
          verticalSpace(16),
          Text(
            _isExpired
                ? context.localizations.request_expired_message
                : context.localizations.arrive_before_timer_message,
            textAlign: TextAlign.center,
            style: context.textStyles.font12TextSecondaryRegular.copyWith(
              height: 1.33,
            ),
          ),
        ],
      ),
    );
  }
}
