import 'package:donor_app/core/enums/district_status.dart';
import 'package:donor_app/core/enums/governorate_status.dart';
import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:donor_app/core/widgets/app_drop_down_button_field.dart';
import 'package:donor_app/core/entities/districts_entity.dart';
import 'package:donor_app/core/entities/governorate_entity.dart';
import 'package:donor_app/core/widgets/blood_type_selector.dart';
import 'package:donor_app/features/profile/presentation/logic/edit_profile/edit_profile_cubit.dart';
import 'package:donor_app/features/profile/presentation/logic/edit_profile/edit_profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileForm extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController phoneNumberController;
  final ValueNotifier<String?> selectedGovernorateId;
  final ValueNotifier<String?> selectedDistrictId;
  final ValueNotifier<String?> selectedBloodType;

  const EditProfileForm({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.phoneNumberController,
    required this.selectedGovernorateId,
    required this.selectedDistrictId,
    required this.selectedBloodType,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileCubit, EditProfileState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: _ProfileFormField(
                    title: context.localizations.first_name,
                    hintText: context.localizations.first_name,
                    controller: firstNameController,
                  ),
                ),
                horizontalSpace(12),
                Expanded(
                  child: _ProfileFormField(
                    title: context.localizations.last_name,
                    hintText: context.localizations.last_name,
                    controller: lastNameController,
                  ),
                ),
              ],
            ),
            verticalSpace(12),
            AppDropdownButtonField<String, GovernorateEntity>(
              isLoading: state.governoratesStatus == GovernoratesStatus.loading,
              controller: selectedGovernorateId,
              items: state.governorates,
              valueBuilder: (item) => item.id,
              labelBuilder: (item) => item.name,
              hintText: context.localizations.select_governorate_hint,
              title: context.localizations.governorate.toUpperCase(),
              onChanged: (value) {
                if (value != null) {
                  selectedDistrictId.value = null;
                  context.read<EditProfileCubit>().getDistrictsByGovernorateId(
                    value,
                  );
                }
              },
            ),
            verticalSpace(12),
            AppDropdownButtonField<String, DistrictsEntity>(
              isLoading: state.districtsStatus == DistrictsStatus.loading,
              controller: selectedDistrictId,
              items: state.districts,
              valueBuilder: (item) => item.id,
              labelBuilder: (item) => item.name,
              hintText: 'Select District',
              title: context.localizations.district.toUpperCase(),
              onChanged: (value) {
                if (value != null) {
                  selectedDistrictId.value = value;
                }
              },
            ),
            verticalSpace(12),
            _ProfileFormField(
              title: context.localizations.phone_number,
              hintText: context.localizations.phone_number,
              controller: phoneNumberController,
              keyboardType: TextInputType.phone,
              prefixText: '+962 ',
            ),
            verticalSpace(16),
            BloodTypeSelector(selectedBloodType: selectedBloodType),
          ],
        );
      },
    );
  }
}

class _ProfileFormField extends StatelessWidget {
  final String title;
  final String hintText;
  final String? prefixText;
  final TextEditingController controller;
  final TextInputType keyboardType;

  const _ProfileFormField({
    required this.title,
    required this.hintText,
    required this.controller,
    this.prefixText,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: context.textStyles.font12SecondaryBold.copyWith(
            letterSpacing: 0.5,
          ),
        ),
        verticalSpace(6),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          style: context.textStyles.font14TextPrimaryBold,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: context.textStyles.font16TextPlaceHolderMedium50Faded,
            prefixText: prefixText,
          ),
        ),
      ],
    );
  }
}
