import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:donor_app/features/all_requests/presentation/widgets/urgency_filter_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllRequestsFilters extends StatelessWidget {
  const AllRequestsFilters({
    super.key,
    required this.controller,
    required this.selectedUrgency,
    required this.onSearch,
    required this.onUrgencySelected,
  });

  final TextEditingController controller;
  final int? selectedUrgency;
  final VoidCallback onSearch;
  final ValueChanged<int?> onUrgencySelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller,
          textInputAction: TextInputAction.search,
          onSubmitted: (_) => onSearch(),
          decoration: InputDecoration(
            hintText: context.localizations.search_requests_hint,
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: const Icon(Icons.search_rounded),
            ),
            suffixIcon: IconButton(
              onPressed: onSearch,
              icon: const Icon(Icons.arrow_forward_rounded),
            ),
            filled: true,
            fillColor: context.colors.navigationBar,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        verticalSpace(12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              UrgencyFilterChip(
                label: context.localizations.all_filter,
                isSelected: selectedUrgency == null,
                onSelected: () => onUrgencySelected(null),
              ),
              horizontalSpace(8),
              UrgencyFilterChip(
                label: context.localizations.normal_filter,
                isSelected: selectedUrgency == 0,
                onSelected: () => onUrgencySelected(0),
              ),
              horizontalSpace(8),
              UrgencyFilterChip(
                label: context.localizations.urgent_filter,
                isSelected: selectedUrgency == 1,
                onSelected: () => onUrgencySelected(1),
              ),
              horizontalSpace(8),
              UrgencyFilterChip(
                label: context.localizations.critical_filter,
                isSelected: selectedUrgency == 2,
                onSelected: () => onUrgencySelected(2),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
