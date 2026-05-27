import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:donor_app/features/requests/domain/entities/active_donation_entity.dart';
import 'package:donor_app/features/requests/presentation/logic/active_donation/active_donation_cubit.dart';
import 'package:donor_app/features/requests/presentation/logic/active_donation/active_donation_state.dart';
import 'package:donor_app/features/requests/presentation/widgets/active_donation/action_buttons_section.dart';
import 'package:donor_app/features/requests/presentation/widgets/active_donation/expiration_countdown_card.dart';
import 'package:donor_app/features/requests/presentation/widgets/active_donation/hospital_summary_card.dart';
import 'package:donor_app/features/requests/presentation/widgets/active_donation/instruction_card.dart';
import 'package:donor_app/features/requests/presentation/widgets/active_donation/map_bento_card.dart';
import 'package:donor_app/features/requests/presentation/widgets/active_donation/status_header_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ActiveDonationScreen extends StatelessWidget {
  const ActiveDonationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: 24.w,
              right: 24.w,
              top: 20.h,
              bottom: 20.h,
            ),
            child: BlocBuilder<ActiveDonationCubit, ActiveDonationState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const SizedBox.shrink(),
                  loading: () => Skeletonizer(
                    enabled: true,
                    child: _buildActiveDonaion(
                      ActiveDonationEntity.placeholder(),
                    ),
                  ),
                  success: (donation) => _buildActiveDonaion(donation),
                  empty: () => Center(
                    child: Text(context.localizations.no_active_donation_found),
                  ),
                  error: (error) =>
                      Center(child: Text(error.getAllErrorMessages())),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActiveDonaion(ActiveDonationEntity donation) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        const StatusHeaderSection(),
        verticalSpace(12),
        MapBentoCard(
          hospitalLat: donation.hospitalLatitude,
          hospitalLng: donation.hospitalLongitude,
        ),
        verticalSpace(32),
        ActionButtonsSection(
          requestId: donation.requestId,
          hospitalPhoneNumber: donation.hospitalPhoneNumber,
        ),
        verticalSpace(32),
        ExpirationCountdownCard(acceptedAt: donation.acceptedAt),
        verticalSpace(32),
        HospitalSummaryCard(donation: donation),
        verticalSpace(32),
        const InstructionCard(),
      ],
    );
  }
}
