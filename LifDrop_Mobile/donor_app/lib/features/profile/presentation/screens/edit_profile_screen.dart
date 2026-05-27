import 'package:donor_app/core/enums/district_status.dart';
import 'package:donor_app/core/enums/governorate_status.dart';
import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:donor_app/core/mixins/snack_bar_mixin.dart';
import 'package:donor_app/features/profile/data/requests/update_profile_request.dart';
import 'package:donor_app/features/profile/domain/entities/user_entity.dart';
import 'package:donor_app/core/enums/blood_type.dart';
import 'package:donor_app/features/profile/presentation/logic/edit_profile/edit_profile_cubit.dart';
import 'package:donor_app/features/profile/presentation/logic/edit_profile/edit_profile_state.dart';
import 'package:donor_app/features/profile/presentation/widgets/edit_profile/edit_profile_form.dart';
import 'package:donor_app/features/profile/presentation/widgets/edit_profile/edit_profile_header.dart';
import 'package:donor_app/features/profile/presentation/widgets/edit_profile/notification_toggles_section.dart';
import 'package:donor_app/features/profile/presentation/widgets/edit_profile/save_changes_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileScreen extends StatefulWidget {
  final UserEntity user;

  const EditProfileScreen({super.key, required this.user});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen>
    with SnackBarMixin {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _phoneNumberController;

  late final ValueNotifier<String?> _selectedGovernorateId;
  late final ValueNotifier<String?> _selectedDistrictId;
  late final ValueNotifier<String?> _selectedBloodType;

  late final ValueNotifier<bool> _availableNotifier;
  late final ValueNotifier<bool> _criticalNotifier;
  late final ValueNotifier<bool> _urgentNotifier;
  late final ValueNotifier<bool> _normalNotifier;

  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.user.firstName);
    _lastNameController = TextEditingController(text: widget.user.lastName);

    String phone = widget.user.phoneNumber;
    if (phone.startsWith('+962')) {
      phone = phone.substring(4);
    }
    _phoneNumberController = TextEditingController(text: phone);

    _selectedGovernorateId = ValueNotifier<String?>(null);
    _selectedDistrictId = ValueNotifier<String?>(null);
    _selectedBloodType = ValueNotifier<String?>(widget.user.bloodType.name);

    _availableNotifier = ValueNotifier<bool>(widget.user.isAvailable);
    _criticalNotifier = ValueNotifier<bool>(
      widget.user.receiveCriticalNotifications,
    );
    _urgentNotifier = ValueNotifier<bool>(
      widget.user.receiveUrgentNotifications,
    );
    _normalNotifier = ValueNotifier<bool>(
      widget.user.receiveNormalNotifications,
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    _selectedGovernorateId.dispose();
    _selectedDistrictId.dispose();
    _selectedBloodType.dispose();
    _criticalNotifier.dispose();
    _urgentNotifier.dispose();
    _normalNotifier.dispose();
    super.dispose();
  }

  bool _validateForm() {
    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    final phone = _phoneNumberController.text.trim();
    final governorateId = _selectedGovernorateId.value;
    final districtId = _selectedDistrictId.value;
    final bloodType = _selectedBloodType.value;

    String? error;

    if (firstName.isEmpty) {
      error = context.localizations.first_name_required;
    } else if (lastName.isEmpty) {
      error = context.localizations.last_name_required;
    } else if (governorateId == null) {
      error = context.localizations.governorate_required;
    } else if (districtId == null) {
      error = context.localizations.district_required;
    } else if (!phone.isDigitsOnly) {
      error = context.localizations.phone_number_digits_only;
    } else if (phone.isEmpty || !phone.isValidJordanPhoneNumber) {
      error = context.localizations.phone_required;
    } else if (bloodType == null) {
      error = context.localizations.blood_type_required;
    }

    if (error != null) {
      showErrorSnackBar(context, message: error, maxLines: null);
      return false;
    }
    return true;
  }

  void _submitProfileUpdate() {
    FocusScope.of(context).unfocus();
    if (_validateForm()) {
      final request = UpdateProfileRequest(
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        phoneNumber: _phoneNumberController.text.formatPhoneNumberJO(),
        bloodType: BloodType.values.byName(_selectedBloodType.value!),
        governorateId: _selectedGovernorateId.value!,
        districtId: _selectedDistrictId.value!,
        isAvailable: _availableNotifier.value,
        receiveCriticalNotifications: _criticalNotifier.value,
        receiveUrgentNotifications: _urgentNotifier.value,
        receiveNormalNotifications: _normalNotifier.value,
      );

      context.read<EditProfileCubit>().updateProfile(request);
    }
  }

  void _handleGovernoratesLoaded(EditProfileState state) {
    if (state.governoratesStatus == GovernoratesStatus.success &&
        !_isInitialized) {
      final govIndex = state.governorates.indexWhere(
        (gov) =>
            gov.name.toLowerCase() == widget.user.governorateName.toLowerCase(),
      );

      final matchGov = govIndex != -1
          ? state.governorates[govIndex]
          : state.governorates[0];
      _selectedGovernorateId.value = matchGov.id;
      _isInitialized = true;
      context.read<EditProfileCubit>().getDistrictsByGovernorateId(matchGov.id);
    }
  }

  void _handleDistrictsLoaded(EditProfileState state) {
    if (state.districtsStatus == DistrictsStatus.success &&
        _selectedDistrictId.value == null) {
      final distIndex = state.districts.indexWhere(
        (dist) =>
            dist.name.toLowerCase() == widget.user.districtName.toLowerCase(),
      );

      final matchedDistrict = distIndex != -1
          ? state.districts[distIndex]
          : state.districts[0];

      _selectedDistrictId.value = matchedDistrict.id;
    }
  }

  void _handleUpdateResult(EditProfileState state) {
    if (state.status == EditProfileStatus.success) {
      showSuccessSnackBar(
        context,
        message: context.localizations.profile_updated_message,
      );
      context.pop<bool>(value: true);
    } else if (state.status == EditProfileStatus.failure &&
        state.error != null) {
      showErrorSnackBar(context, message: state.error!.getAllErrorMessages());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        _handleGovernoratesLoaded(state);
        _handleDistrictsLoaded(state);
        _handleUpdateResult(state);
      },
      builder: (context, state) {
        return Scaffold(
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            behavior: HitTestBehavior.opaque,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    const EditProfileHeader(),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            verticalSpace(10),
                            EditProfileForm(
                              firstNameController: _firstNameController,
                              lastNameController: _lastNameController,
                              phoneNumberController: _phoneNumberController,
                              selectedGovernorateId: _selectedGovernorateId,
                              selectedDistrictId: _selectedDistrictId,
                              selectedBloodType: _selectedBloodType,
                            ),
                            verticalSpace(24),
                            Text(
                              context.localizations.notifications_label
                                  .toUpperCase(),
                              style: context.textStyles.font12SecondaryBold
                                  .copyWith(letterSpacing: 0.5),
                            ),
                            verticalSpace(12),
                            NotificationTogglesSection(
                              availableNotifier: _availableNotifier,
                              criticalNotifier: _criticalNotifier,
                              urgentNotifier: _urgentNotifier,
                              normalNotifier: _normalNotifier,
                            ),
                            verticalSpace(36),
                            SaveChangesButton(
                              onPressed: _submitProfileUpdate,
                              isLoading:
                                  state.status == EditProfileStatus.loading,
                            ),
                            verticalSpace(24),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
