import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:donor_app/core/enums/blood_type.dart';
import 'package:donor_app/core/widgets/blood_type_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BloodTypeSelector extends StatelessWidget {
  const BloodTypeSelector({super.key, required this.selectedBloodType});

  final ValueNotifier<String?> selectedBloodType;

  final List<BloodType> bloodTypes = const [
    BloodType.O_Positive,
    BloodType.O_Negative,
    BloodType.A_Positive,
    BloodType.A_Negative,
    BloodType.B_Positive,
    BloodType.B_Negative,
    BloodType.AB_Positive,
    BloodType.AB_Negative,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              context.localizations.select_blood_type,
              style: context.textStyles.font12SecondaryBold.copyWith(
                letterSpacing: 1.2,
              ),
            ),
            const Spacer(),
            Text(
              context.localizations.required,
              style: context.textStyles.font10PrimaryBold.copyWith(
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
        verticalSpace(12),
        ValueListenableBuilder<String?>(
          valueListenable: selectedBloodType,
          builder: (context, selectedValue, _) {
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 10.h,
                crossAxisSpacing: 10.w,
              ),
              itemCount: bloodTypes.length,
              itemBuilder: (context, index) {
                final type = bloodTypes[index];
                return BloodTypeOption(
                  isSelected: selectedValue == type.name,
                  title: type.label,
                  onTap: () {
                    selectedBloodType.value = type.name;
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }
}
