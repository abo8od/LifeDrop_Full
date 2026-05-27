import 'dart:ui';

import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/location_helper.dart';
import 'package:donor_app/core/resources/image_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MapBentoCard extends StatelessWidget {
  const MapBentoCard({
    super.key,
    required this.hospitalLat,
    required this.hospitalLng,
  });
  final double hospitalLat;
  final double hospitalLng;

  Future<String> getDistance() {
    return LocationHelper.getDistance(hospitalLat, hospitalLng);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        LocationHelper.openDirections(hospitalLat, hospitalLat);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          height: 192.h,
          width: double.infinity,
          child: Stack(
            children: [
              Positioned.fill(
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Colors.white.withAlpha(51),
                    BlendMode.saturation,
                  ),
                  child: Opacity(
                    opacity: 0.8,
                    child: Image.asset(ImagePaths.map, fit: BoxFit.cover),
                  ),
                ),
              ),

              Positioned(
                top: 16.h,
                left: 16.w,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                    child: Container(
                      width: 145.w,
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: context.colors.background.withAlpha(204),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white.withAlpha(51)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'ETA',
                            style: context.textStyles.font10SecondaryBold
                                .copyWith(letterSpacing: 1),
                          ),
                          SizedBox(height: 4.h),
                          FutureBuilder(
                            future: getDistance(),
                            builder: (context, snapshot) {
                              final distance = snapshot.data ?? '';
                              return Text(
                                distance,
                                style: context
                                    .textStyles
                                    .font12TextSecondaryRegular,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 16.h,
                right: 16.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 9.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: context.colors.primary,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.navigation_outlined,
                      color: context.colors.background,
                      size: 25,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
