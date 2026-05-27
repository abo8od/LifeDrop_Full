import 'package:donor_app/core/enums/donation_status.dart';
import 'package:donor_app/core/helpers/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HistoryStatusChip extends StatelessWidget {
  const HistoryStatusChip({super.key, required this.status});

  final DonationStatus status;

  @override
  Widget build(BuildContext context) {
    final colors = _statusColors(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        _label,
        style: context.textStyles.font10TextSecondaryBold.copyWith(
          color: colors.foreground,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  String get _label {
    switch (status) {
      case DonationStatus.Accepted:
        return 'ACCEPTED';
      case DonationStatus.Fulfilled:
        return 'FULFILLED';
      case DonationStatus.CancelledByDonor:
        return 'CANCELLED';
      case DonationStatus.CancelledByHospital:
        return 'CANCELLED';
      case DonationStatus.NoShow:
        return 'NO SHOW';
    }
  }

  _HistoryStatusColors _statusColors(BuildContext context) {
    switch (status) {
      case DonationStatus.Fulfilled:
        return _HistoryStatusColors(
          background: context.colors.tertiary,
          foreground: context.colors.secondary,
        );
      case DonationStatus.CancelledByDonor:
      case DonationStatus.CancelledByHospital:
      case DonationStatus.NoShow:
        return _HistoryStatusColors(
          background: context.colors.surface.withAlpha(120),
          foreground: context.colors.iconInactive,
        );
      case DonationStatus.Accepted:
        return _HistoryStatusColors(
          background: context.colors.iconActiveBackground.withAlpha(170),
          foreground: context.colors.primary,
        );
    }
  }
}

class _HistoryStatusColors {
  const _HistoryStatusColors({
    required this.background,
    required this.foreground,
  });

  final Color background;
  final Color foreground;
}
