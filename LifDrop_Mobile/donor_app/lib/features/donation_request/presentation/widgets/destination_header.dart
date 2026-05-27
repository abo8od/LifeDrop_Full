import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:donor_app/features/donation_request/presentation/widgets/destination_label_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DestinationHeader extends StatelessWidget {
  const DestinationHeader({super.key, required this.lat, required this.lng});
  final double lat;
  final double lng;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: .start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: context.colors.tertiary,
          ),
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          child: Icon(
            Icons.location_on_outlined,
            size: 25,
            color: context.colors.secondary,
          ),
        ),
        horizontalSpace(16),
        DestinationLabelSection(lat: lat, lng: lng),
      ],
    );
  }
}
