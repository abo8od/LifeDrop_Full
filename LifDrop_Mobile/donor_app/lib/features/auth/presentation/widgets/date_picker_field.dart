import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class DatePickerField extends StatelessWidget {
  const DatePickerField({super.key, required this.controller});
  final ValueNotifier<String?> controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now().subtract(const Duration(days: 365 * 100)),
          lastDate: DateTime.now(),
        );
        if (date != null) {
          controller.value = DateFormat('yyyy-MM-dd').format(date);
        }
      },
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Text(
            context.localizations.birth_date,
            style: context.textStyles.font12SecondaryBold,
          ),
          verticalSpace(6),
          ValueListenableBuilder(
            valueListenable: controller,
            builder: (context, date, child) {
              return Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                decoration: BoxDecoration(
                  color: context.colors.surface,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Text(
                      date ?? 'Select Date of Birth',
                      style: date != null
                          ? context.textStyles.font16TextPrimaryBold
                          : context
                                .textStyles
                                .font16TextPlaceHolderMedium50Faded,
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.calendar_month_outlined,
                      color: Colors.grey,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
