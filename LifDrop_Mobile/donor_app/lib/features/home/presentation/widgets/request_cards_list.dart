import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:donor_app/core/routing/routes.dart';
import 'package:donor_app/core/widgets/app_text_button.dart';
import 'package:donor_app/features/home/domain/entities/donation_request_entity.dart';
import 'package:donor_app/features/home/presentation/widgets/donation_request_card.dart';
import 'package:donor_app/features/requests/presentation/logic/active_donation/active_donation_cubit.dart';
import 'package:flutter/material.dart';

class RequestCardsList extends StatelessWidget {
  const RequestCardsList({
    super.key,
    required this.requests,
    this.maxVisibleRequests,
    required this.canDonate,
    this.canScroll = false,
    this.activeDonationCubit,
  });
  final List<DonationRequestEntity> requests;
  final int? maxVisibleRequests;
  final bool canDonate;
  final bool canScroll;
  final ActiveDonationCubit? activeDonationCubit;

  @override
  Widget build(BuildContext context) {
    final visibleRequests = maxVisibleRequests == null
        ? requests
        : requests.take(maxVisibleRequests!).toList();
    if (visibleRequests.isEmpty) {
      return Center(
        child: Text(context.localizations.no_active_requests_found),
      );
    }
    return Container(
      decoration: BoxDecoration(
        color: canScroll ? null : context.colors.neutral,
        borderRadius: canScroll ? null : BorderRadius.circular(12),
      ),
      padding: canScroll ? null : const EdgeInsets.all(12),
      child: Column(
        children: [
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: visibleRequests.length,
            itemBuilder: (context, index) {
              final request = visibleRequests[index];
              return DonationRequestCard(
                bloodType: request.bloodType,
                urgencyStatus: request.urgency.name.toUpperCase(),
                hospitalName: request.hospitalName,
                isCritical: request.isCritical,
                onPressed: () {
                  context.pushNamed(
                    Routes.requestDetails,
                    arguments: {
                      'requestId': request.requestId,
                      'canDonate': canDonate,
                      'activeDonationCubit': activeDonationCubit,
                    },
                  );
                },
              );
            },

            separatorBuilder: (context, index) => verticalSpace(16),
          ),
          if (!canScroll) verticalSpace(25),
          if (!canScroll)
            AppTextButton(
              isLoading: false,
              onPressed: () => context.pushNamed(
                Routes.requests,
                arguments: {
                  'activeDonationCubit': activeDonationCubit,
                  'canDonate': canDonate,
                },
              ),
              buttonText: context.localizations.view_all_requests,
              textStyle: context.textStyles.font16WhiteBold,
              isIconRight: true,
              icon: Icon(
                Icons.arrow_forward,
                color: context.colors.textPrimary,
              ),
            ),
        ],
      ),
    );
  }
}
