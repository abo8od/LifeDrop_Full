import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/location_helper.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:flutter/material.dart';

class DestinationLabelSection extends StatelessWidget {
  const DestinationLabelSection({
    super.key,
    required this.lat,
    required this.lng,
  });
  final double lat;
  final double lng;

  Future<String> getAddress() async {
    return await LocationHelper.getAddressFromLatLng(lat, lng);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          'DESTINATION',
          style: context.textStyles.font12SecondaryBold.copyWith(
            letterSpacing: 1.2,
          ),
        ),
        verticalSpace(2),
        Text(
          'Central Medical Plaza',
          style: context.textStyles.font18TextPrimaryBold.copyWith(
            letterSpacing: 0,
          ),
        ),
        verticalSpace(1),
        FutureBuilder(
          future: getAddress(),
          builder: (context, snapshot) {
            final address = snapshot.data ?? '';
            return Text(
              address,
              style: context.textStyles.font14TextSecondaryRegular.copyWith(
                letterSpacing: 0,
              ),
            );
          },
        ),
      ],
    );
  }
}
