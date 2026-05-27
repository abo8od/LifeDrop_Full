// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum ImageType { network, asset, svg }

class AppImages extends StatelessWidget {
  final String path;
  final ImageType type;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Color? color;

  const AppImages({
    super.key,
    required this.path,
    required this.type,
    this.width,
    this.height,
    this.color,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    if (type == ImageType.network) {
      return CachedNetworkImage(
        imageUrl: path,
        width: width?.w,
        height: height?.h,
        fit: fit,
        placeholder: (context, url) =>
            const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      );
    } else if (type == ImageType.asset) {
      return Image.asset(path, width: width?.w, height: height?.h, fit: fit);
    } else {
      return SvgPicture.asset(
        path,
        width: width?.w,
        height: height?.h,
        fit: fit,
        colorFilter: color != null
            ? ColorFilter.mode(color!, BlendMode.srcIn)
            : null,
      );
    }
  }
}
