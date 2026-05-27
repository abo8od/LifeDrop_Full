import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:donor_app/features/donation_history/domain/entities/donation_history_entity.dart';
import 'package:donor_app/features/donation_history/presentation/widgets/history_status_chip.dart';
import 'package:donor_app/features/home/presentation/widgets/blood_type_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class DonationHistoryCard extends StatelessWidget {
  const DonationHistoryCard({super.key, required this.history});

  final DonationHistoryEntity history;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: context.colors.navigationBar,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BloodTypeBadge(
                bloodType: history.bloodType.label,
                isUrgent: history.pointsEarned > 0,
              ),
              horizontalSpace(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      history.hospitalName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: context.textStyles.font16TextPrimaryBold,
                    ),
                    verticalSpace(6),
                    Text(
                      DateFormat(
                        'MMM d, yyyy - h:mm a',
                      ).format(history.date.toLocal()),
                      style: context.textStyles.font12TextPlaceHolderRegular,
                    ),
                  ],
                ),
              ),
              horizontalSpace(8),
              HistoryStatusChip(status: history.status),
            ],
          ),
          verticalSpace(16),
          Divider(color: context.colors.primary.withAlpha(22), height: 1),
          verticalSpace(14),
          Row(
            children: [
              Text(
                'Points earned',
                style: context.textStyles.font12TextSecondaryMedium,
              ),
              const Spacer(),
              Text(
                '+${history.pointsEarned}',
                style: context.textStyles.font16PrimaryBold.copyWith(
                  color: history.pointsEarned > 0
                      ? context.colors.primary
                      : context.colors.iconInactive,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
