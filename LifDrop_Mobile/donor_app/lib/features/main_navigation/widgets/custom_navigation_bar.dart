import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/resources/image_paths.dart';
import 'package:donor_app/features/main_navigation/widgets/navigation_item.dart';
import 'package:flutter/material.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });
  final int currentIndex;
  final void Function(int index) onTap;

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  List<String> get _paths => [
    ImagePaths.homeIcon,
    ImagePaths.requestIcon,
    ImagePaths.historyIcon,
    ImagePaths.profileIcon,
  ];

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      key: _bottomNavigationKey,
      height: 60,
      color: context.colors.navigationBar,
      buttonBackgroundColor: Colors.transparent,
      backgroundColor: context.colors.background,
      index: widget.currentIndex,
      onTap: widget.onTap,
      items: List.generate(_paths.length, (index) {
        return NavigationItem(
          path: _paths[index],
          isSelected: widget.currentIndex == index,
        );
      }),
    );
  }
}
