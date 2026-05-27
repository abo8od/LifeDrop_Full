import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/widgets/app_images.dart';
import 'package:flutter/material.dart';

class NavigationItem extends StatelessWidget {
  const NavigationItem({
    super.key,
    required this.isSelected,
    required this.path,
  });
  final String path;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return AppImages(
      path: path,
      color: isSelected
          ? context.colors.iconActive
          : context.colors.iconInactive,
      type: ImageType.svg,
      width: 18,
      height: 18,
    );
  }
}
