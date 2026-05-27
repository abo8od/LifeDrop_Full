import 'package:flutter/material.dart';

class UrgencyIndicator extends StatelessWidget {
  const UrgencyIndicator({
    super.key,
    required this.urgencyStatus,
    required this.statusStyle,
  });
  final String urgencyStatus;
  final TextStyle statusStyle;

  @override
  Widget build(BuildContext context) {
    return Text(urgencyStatus, style: statusStyle);
  }
}
