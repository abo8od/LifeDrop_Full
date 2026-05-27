import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/location_helper.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:donor_app/core/resources/image_paths.dart';
import 'package:donor_app/core/widgets/app_images.dart';
import 'package:donor_app/features/donation_request/presentation/widgets/direction_button.dart';
import 'package:donor_app/features/donation_request/presentation/widgets/title_hospital_location.dart';
import 'package:flutter/material.dart';

class HospitalLocationCard extends StatelessWidget {
  const HospitalLocationCard({super.key, required this.lat, required this.lng});
  final double lat;
  final double lng;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.navigationBar,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          TitleHospitalLocation(lat: lat, lng: lng),
          verticalSpace(12),
          const AppImages(path: ImagePaths.location, type: ImageType.asset),
          DirectionButton(
            onTap: () {
              LocationHelper.openDirections(lat, lng);
            },
          ),
        ],
      ),
    );
  }
}
