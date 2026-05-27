import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/location_helper.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:flutter/material.dart';

class DonationHeader extends StatelessWidget {
  const DonationHeader({
    super.key,
    required this.hospitalLatitude,
    required this.hospitalLongitude,
    required this.hospitalName,
  });
  final String hospitalName;
  final double hospitalLatitude;
  final double hospitalLongitude;

  Future<String> getAddress(double lan, double lon) async {
    return LocationHelper.getAddressFromLatLng(lan, lon);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.localizations.destination_label,
          style: context.textStyles.font10SecondaryBold.copyWith(
            letterSpacing: 1,
          ),
        ),
        verticalSpace(4),
        Text(hospitalName, style: context.textStyles.font20TextPrimaryBold),
        verticalSpace(4),
        FutureBuilder(
          future: getAddress(hospitalLatitude.toDouble(), hospitalLongitude),
          builder: (context, snapshot) {
            final address = snapshot.data ?? '';
            return Text(
              address,
              style: context.textStyles.font14TextSecondaryRegular,
            );
          },
        ),
      ],
    );
  }
}
