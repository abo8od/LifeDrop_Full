import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:donor_app/core/widgets/app_drop_down_button_field.dart';
import 'package:donor_app/core/widgets/app_slide_fade_animation.dart';
import 'package:donor_app/core/entities/districts_entity.dart';
import 'package:donor_app/core/entities/governorate_entity.dart';
import 'package:donor_app/features/auth/presentation/logic/register/register_cubit.dart';
import 'package:donor_app/features/auth/presentation/logic/register/register_state.dart';
import 'package:donor_app/features/auth/presentation/widgets/auth_text_section.dart';
import 'package:donor_app/core/widgets/blood_type_selector.dart';
import 'package:donor_app/features/auth/presentation/widgets/date_picker_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterSectionTwo extends StatefulWidget {
  const RegisterSectionTwo({
    super.key,
    required this.selectedBirthDate,
    required this.selectedBloodType,
    required this.selectedGovernorateId,
    required this.selectedDistrictId,
  });
  final ValueNotifier<String?> selectedBirthDate;
  final ValueNotifier<String?> selectedBloodType;
  final ValueNotifier<String?> selectedGovernorateId;
  final ValueNotifier<String?> selectedDistrictId;

  @override
  State<RegisterSectionTwo> createState() => _RegisterSectionTwoState();
}

class _RegisterSectionTwoState extends State<RegisterSectionTwo> {
  void _init() {
    if (mounted) {
      context.read<RegisterCubit>().getGovernorates();
    }
  }

  @override
  void initState() {
    super.initState();

    _init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: .start,
          children: [
            AppSlideFadeAnimation(
              delay: 0,
              child: AuthTextSection(
                title: context.localizations.register,
                subtitle: context.localizations.more_info,
              ),
            ),
            verticalSpace(35),
            AppSlideFadeAnimation(
              delay: 150,
              child: DatePickerField(controller: widget.selectedBirthDate),
            ),
            verticalSpace(12),
            AppSlideFadeAnimation(
              delay: 200,
              child: AppDropdownButtonField<String, GovernorateEntity>(
                isLoading:
                    state.governoratesStatus == GovernoratesStatus.loading,
                controller: widget.selectedGovernorateId,
                items: state.governorates,
                valueBuilder: (item) => item.id,
                labelBuilder: (item) => item.name,
                hintText: 'Select Governorate',
                title: context.localizations.governorate,
                onChanged: (value) {
                  if (value != null) {
                    // reset district selection
                    widget.selectedDistrictId.value = null;

                    context.read<RegisterCubit>().getDistrictsByGovernorateId(
                      value,
                    );
                  }
                },
              ),
            ),
            verticalSpace(12),
            AppSlideFadeAnimation(
              delay: 250,
              child: AppDropdownButtonField<String, DistrictsEntity>(
                isLoading: state.districtsStatus == DistrictsStatus.loading,
                controller: widget.selectedDistrictId,
                items: state.districts,
                valueBuilder: (item) => item.id,
                labelBuilder: (item) => item.name,
                hintText: 'Select District',
                title: context.localizations.district,
                onChanged: (value) {
                  if (value != null) {
                    widget.selectedDistrictId.value = value;
                  }
                },
              ),
            ),
            verticalSpace(12),
            AppSlideFadeAnimation(
              delay: 300,
              child: BloodTypeSelector(
                selectedBloodType: widget.selectedBloodType,
              ),
            ),
          ],
        );
      },
    );
  }
}
