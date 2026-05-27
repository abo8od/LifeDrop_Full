import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:donor_app/core/routing/routes.dart';
import 'package:donor_app/features/all_requests/domain/entities/donation_request_feed_entity.dart';
import 'package:donor_app/features/home/presentation/widgets/donation_request_card.dart';
import 'package:donor_app/features/requests/presentation/logic/active_donation/active_donation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllRequestsContent extends StatelessWidget {
  const AllRequestsContent({
    super.key,
    required this.requests,
    required this.isLoadingMore,
    required this.totalCount,
    required this.onNearBottom,
    required this.canDonate,
    this.activeDonationCubit,
  });

  final List<DonationRequestFeedEntity> requests;
  final bool isLoadingMore;
  final int totalCount;
  final VoidCallback onNearBottom;
  final bool canDonate;
  final ActiveDonationCubit? activeDonationCubit;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        final metrics = notification.metrics;
        if (metrics.pixels >= metrics.maxScrollExtent - 180.h) {
          onNearBottom();
        }
        return false;
      },
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Text(
                context.localizations.all_requests_count(totalCount),
                style: context.textStyles.font14TextPlaceHolderRegular,
              ),
            ),
          ),
          SliverList.separated(
            itemCount: requests.length,
            separatorBuilder: (context, index) => verticalSpace(16),
            itemBuilder: (context, index) {
              final request = requests[index];
              return DonationRequestCard(
                bloodType: request.requiredBloodType,
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
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 16.h, bottom: 24.h),
              child: isLoadingMore
                  ? Center(
                      child: SizedBox(
                        width: 22.w,
                        height: 22.w,
                        child: const CircularProgressIndicator(strokeWidth: 2),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}
