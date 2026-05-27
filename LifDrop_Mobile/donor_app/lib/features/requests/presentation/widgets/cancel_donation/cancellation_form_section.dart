import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:donor_app/core/mixins/snack_bar_mixin.dart';
import 'package:donor_app/core/widgets/app_drop_down_button_field.dart';
import 'package:donor_app/features/requests/domain/entities/donation_cancellation_reasons_entity.dart';
import 'package:donor_app/features/requests/presentation/logic/cancel_donation/cancel_donation_cubit.dart';
import 'package:donor_app/features/requests/presentation/logic/cancellation_reasons/cancellation_reasons_cubit.dart';
import 'package:donor_app/features/requests/presentation/logic/cancellation_reasons/cancellation_reasons_state.dart';
import 'package:donor_app/features/requests/presentation/widgets/cancel_donation/cancel_buttons_section.dart';
import 'package:donor_app/features/requests/presentation/widgets/cancel_donation/note_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CancellationFormSection extends StatelessWidget with SnackBarMixin {
  const CancellationFormSection({
    super.key,
    required this.cancelReasonIdNotifier,
    required this.noteController,
    required this.requestId,
  });
  final ValueNotifier<String?> cancelReasonIdNotifier;
  final TextEditingController noteController;
  final String requestId;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.neutral,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 24.w),
      child: Column(
        children: [
          BlocBuilder<CancellationReasonsCubit, CancellationReasonsState>(
            builder: (context, state) {
              return AppDropdownButtonField<
                String,
                DonationCancellationReasonsEntity
              >(
                isLoading: state.status == .loading,
                controller: cancelReasonIdNotifier,
                items: state.reasons,
                valueBuilder: (item) => item.id,
                labelBuilder: (item) =>
                    context.isArabic ? item.displayNameAr : item.displayNameEn,
                title: context.localizations.select_cancellation_reason_title,
                hintText: context.localizations.select_reason_hint,
                isDense: context.isArabic,
              );
            },
          ),
          verticalSpace(12),
          NoteBox(noteController: noteController),
          verticalSpace(15),
          Text(
            context.localizations.cancellation_health_warning,
            style: context.textStyles.font12TextSecondaryRegular,
          ),
          verticalSpace(20),
          CancelButtonsSection(
            onPressed: () {
              FocusScope.of(context).unfocus();
              if (cancelReasonIdNotifier.value == null) {
                showErrorSnackBar(
                  context,
                  message: context.localizations.reason_required_error,
                );
              } else {
                context.read<CancelDonationCubit>().cancelDonation(
                  requestId: requestId,
                  reasonId: cancelReasonIdNotifier.value!,
                  note: noteController.text,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
