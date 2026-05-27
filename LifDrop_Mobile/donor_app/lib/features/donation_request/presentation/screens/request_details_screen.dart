import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:donor_app/core/mixins/snack_bar_mixin.dart';
import 'package:donor_app/core/routing/routes.dart';
import 'package:donor_app/core/widgets/app_header.dart';
import 'package:donor_app/core/widgets/app_text_button.dart';
import 'package:donor_app/features/donation_request/domain/entities/request_details_entity.dart';
import 'package:donor_app/features/donation_request/presentation/logic/donation_request_cubit.dart';
import 'package:donor_app/features/donation_request/presentation/logic/donation_request_state.dart';
import 'package:donor_app/features/donation_request/presentation/widgets/critical_request_banner.dart';
import 'package:donor_app/features/donation_request/presentation/widgets/donation_progress_card.dart';
import 'package:donor_app/features/donation_request/presentation/widgets/hospital_location_card.dart';
import 'package:donor_app/features/requests/presentation/logic/active_donation/active_donation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class RequestDetailsScreen extends StatelessWidget with SnackBarMixin {
  const RequestDetailsScreen({
    super.key,
    required this.requestId,
    required this.canDonate,
    this.activeDonationCubit,
  });

  final String requestId;
  final ActiveDonationCubit? activeDonationCubit;
  final bool canDonate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.only(
            left: 24.w,
            right: 24.w,
            bottom: 5.h,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                AppHeader(
                  icon: GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: const Icon(Icons.arrow_back),
                  ),
                  title: context.localizations.request_details,
                  style: context.textStyles.font18TextPrimaryBold.copyWith(
                    letterSpacing: -0.45,
                  ),
                ),
                verticalSpace(20),
                BlocConsumer<DonationRequestCubit, DonationRequestState>(
                  listener: (context, state) {
                    state.whenOrNull(
                      acceptSuccess: (acceptance, request) {
                        activeDonationCubit?.getCurrentActiveDonation();
                        context.pushReplacementNamed(
                          Routes.requestAccepted,
                          arguments: {
                            'hospitalLatitude': request.hospitalLatitude,
                            'hospitalLongitude': request.hospitalLongitude,
                          },
                        );
                      },
                      acceptError: (error, request) {
                        showErrorSnackBar(
                          context,
                          message: error.getAllErrorMessages(),
                        );
                      },
                    );
                  },
                  builder: (context, state) {
                    return state.when(
                      initial: () => const SizedBox.shrink(),
                      detailsLoading: () => Skeletonizer(
                        enabled: true,
                        child: _buildRequestDetails(
                          context,
                          RequestDetailsEntity.placeholder(),
                        ),
                      ),
                      detailsSuccess: (request) =>
                          _buildRequestDetails(context, request),
                      detailsError: (error) =>
                          Center(child: Text(error.getAllErrorMessages())),
                      acceptLoading: (request) => _buildRequestDetails(
                        context,
                        request,
                        isAccepting: true,
                      ),
                      acceptSuccess: (acceptance, request) =>
                          _buildRequestDetails(context, request),
                      acceptError: (error, request) =>
                          _buildRequestDetails(context, request),
                    );
                  },
                ),
                verticalSpace(15),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRequestDetails(
    BuildContext context,
    RequestDetailsEntity request, {
    bool isAccepting = false,
  }) {
    return Column(
      children: [
        CriticalRequestBanner(
          priority: request.urgency.name,
          requestHeadline: '${request.urgency.name} Blood Needed',
          hospitalName: request.hospitalName,
          bloodType: request.requiredBloodType.label,
        ),
        if (request.canAccept && canDonate) ...[
          verticalSpace(15),
          // TODO:: handle it
          const DonationProgressCard(confirmedDonors: 2, totalDonors: 5),
        ],
        verticalSpace(15),
        HospitalLocationCard(
          lat: request.hospitalLatitude,
          lng: request.hospitalLongitude,
        ),
        if (request.canAccept && canDonate) ...[
          verticalSpace(20),
          AppTextButton(
            buttonText: context.localizations.accept_request,
            textStyle: context.textStyles.font16WhiteBold,
            isLoading: isAccepting,
            onPressed: () {
              context.read<DonationRequestCubit>().acceptRequest(request);
            },
          ),
        ],
      ],
    );
  }
}
