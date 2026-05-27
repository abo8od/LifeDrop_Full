import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/location_helper.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TitleHospitalLocation extends StatelessWidget {
  const TitleHospitalLocation({
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
    return Padding(
      padding: EdgeInsets.only(top: 24.h, right: 24.w, left: 24.w),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Text(
            context.localizations.hospital_location,
            style: context.textStyles.font18TextPrimaryBold,
          ),
          verticalSpace(4),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 15,
                color: context.colors.textSecondary,
              ),
              horizontalSpace(4),
              FutureBuilder(
                future: getAddress(),
                builder: (context, snapshot) {
                  final address = snapshot.data ?? '';
                  return Text(
                    address,
                    style: context.textStyles.font14TextSecondaryRegular,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
