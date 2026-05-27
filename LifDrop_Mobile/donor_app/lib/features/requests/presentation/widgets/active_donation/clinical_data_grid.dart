import 'package:donor_app/core/enums/blood_type.dart';
import 'package:donor_app/core/enums/urgency_status.dart';
import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:donor_app/features/requests/presentation/widgets/active_donation/clinical_data_cell.dart';
import 'package:flutter/material.dart';

class ClinicalDataGrid extends StatelessWidget {
  const ClinicalDataGrid({
    super.key,
    required this.bloodType,
    required this.unitsRequested,
    required this.urgency,
  });
  final BloodType bloodType;
  final int unitsRequested;
  final UrgencyStatus urgency;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: [
              ClinicalDataCell(
                label: context.localizations.blood_type_label,
                icon: Icons.water_drop_outlined,
                value: bloodType.label,
              ),
              verticalSpace(16),
              ClinicalDataCell(
                label: context.localizations.units_requested_label,
                icon: Icons.science_outlined,
                value: context.localizations.units(unitsRequested),
              ),
            ],
          ),
        ),
        horizontalSpace(16),
        Expanded(
          child: Column(
            children: [
              ClinicalDataCell(
                label: context.localizations.priority_label,
                icon: Icons.priority_high,
                value: urgency.name,
                valueColor: context.colors.primary,
              ),
              verticalSpace(16),
              ClinicalDataCell(
                label: context.localizations.impact_label,
                icon: Icons.favorite_border,
                value: context.localizations.saves_lives_value,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
