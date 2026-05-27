import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/location_helper.dart';
import 'package:donor_app/core/resources/image_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RouteMapSection extends StatelessWidget {
  const RouteMapSection({super.key, required this.lat, required this.lng});
  final double lat;
  final double lng;

  Future<String> getDistance() async {
    return await LocationHelper.getDistance(lat, lng);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 140.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: const DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(ImagePaths.map),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: context.colors.primary,
            borderRadius: BorderRadius.circular(30),
          ),
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
          child: FutureBuilder(
            future: getDistance(),
            builder: (context, snapshot) {
              final distance = snapshot.data ?? '';
              return Text(distance, style: context.textStyles.font12WhiteBold);
            },
          ),
        ),
      ],
    );
  }
}
