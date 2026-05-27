import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:donor_app/features/requests/domain/entities/active_donation_entity.dart';
import 'package:donor_app/features/requests/presentation/widgets/active_donation/clinical_data_grid.dart';
import 'package:donor_app/features/requests/presentation/widgets/active_donation/donation_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HospitalSummaryCard extends StatelessWidget {
  const HospitalSummaryCard({super.key, required this.donation});
  final ActiveDonationEntity donation;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: context.colors.neutral,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DonationHeader(
            hospitalLatitude: donation.hospitalLatitude,
            hospitalLongitude: donation.hospitalLongitude,
            hospitalName: donation.hospitalName,
          ),
          verticalSpace(10),
          Divider(color: context.colors.primary.withAlpha(25), height: 1),
          verticalSpace(15),
          ClinicalDataGrid(
            bloodType: donation.requiredBloodType,
            unitsRequested: donation.unitsRequested,
            urgency: donation.urgency,
          ),
        ],
      ),
    );
  }
}
