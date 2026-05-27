import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:donor_app/features/donation_request/presentation/widgets/destination_header.dart';
import 'package:donor_app/features/donation_request/presentation/widgets/instruction_section.dart';
import 'package:donor_app/features/donation_request/presentation/widgets/route_map_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DestinationCard extends StatelessWidget {
  const DestinationCard({super.key, required this.lat, required this.lng});
  final double lat;
  final double lng;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.navigationBar,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      child: Column(
        children: [
          DestinationHeader(lat: lat, lng: lng),
          verticalSpace(24),
          RouteMapSection(lat: lat, lng: lng),
          verticalSpace(24),
          const InstructionSection(),
        ],
      ),
    );
  }
}
