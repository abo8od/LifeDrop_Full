import 'package:donor_app/core/helpers/extensions.dart';
import 'package:flutter/material.dart';

class UrgencyFilterChip extends StatelessWidget {
  const UrgencyFilterChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onSelected,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onSelected(),
      selectedColor: context.colors.primary,
      backgroundColor: context.colors.navigationBar,
      labelStyle: isSelected
          ? context.textStyles.font14WhiteBold
          : context.textStyles.font14TextPrimaryRegular,
      side: BorderSide.none,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }
}
