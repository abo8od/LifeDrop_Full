import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:donor_app/core/mixins/snack_bar_mixin.dart';
import 'package:donor_app/features/requests/presentation/logic/cancel_donation/cancel_donation_cubit.dart';
import 'package:donor_app/features/requests/presentation/logic/cancel_donation/cancel_donation_state.dart';
import 'package:donor_app/features/requests/presentation/widgets/cancel_donation/cancellation_form_section.dart';
import 'package:donor_app/features/requests/presentation/widgets/cancel_donation/cancellation_section_header.dart';
import 'package:donor_app/features/requests/presentation/widgets/cancel_donation/impact_warning_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CancelDonationScreen extends StatefulWidget {
  const CancelDonationScreen({super.key, required this.requestId});
  final String requestId;

  @override
  State<CancelDonationScreen> createState() => _CancelDonationScreenState();
}

class _CancelDonationScreenState extends State<CancelDonationScreen>
    with SnackBarMixin {
  final _cancelReasonNotifier = ValueNotifier<String?>(null);
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _cancelReasonNotifier.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CancelDonationCubit, CancelDonationState>(
      listener: (context, state) {
        if (state is CancelDonationSuccess) {
          showSuccessSnackBar(
            context,
            message: context.localizations.donation_cancelled_success,
          );
          context.pop<bool>(value: true);
        }

        if (state is CancelDonationError) {
          showErrorSnackBar(
            context,
            message: state.error.getAllErrorMessages(),
          );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsetsGeometry.only(
                left: 24.w,
                right: 24.w,
                bottom: 20.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CancellationSectionHeader(),
                  verticalSpace(25),
                  const ImpactWarningCard(),
                  verticalSpace(25),
                  CancellationFormSection(
                    cancelReasonIdNotifier: _cancelReasonNotifier,
                    noteController: _noteController,
                    requestId: widget.requestId,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
