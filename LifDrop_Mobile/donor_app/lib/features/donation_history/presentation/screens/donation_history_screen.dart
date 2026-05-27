import 'package:donor_app/core/enums/blood_type.dart';
import 'package:donor_app/core/enums/donation_status.dart';
import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:donor_app/core/widgets/app_elevated_button.dart';
import 'package:donor_app/features/donation_history/domain/entities/donation_history_entity.dart';
import 'package:donor_app/features/donation_history/presentation/logic/donation_history_cubit.dart';
import 'package:donor_app/features/donation_history/presentation/logic/donation_history_state.dart';
import 'package:donor_app/features/donation_history/presentation/widgets/donation_history_card.dart';
import 'package:donor_app/features/donation_history/presentation/widgets/donation_history_empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DonationHistoryScreen extends StatelessWidget {
  const DonationHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: BlocBuilder<DonationHistoryCubit, DonationHistoryState>(
            builder: (context, state) {
              return switch (state) {
                DonationHistoryInitial() => const SizedBox.shrink(),
                DonationHistoryLoading() => Skeletonizer(
                  child: _HistoryContent(
                    histories: _placeholderHistories,
                    isLoadingMore: false,
                    totalCount: 3,
                    onNearBottom: () {},
                  ),
                ),
                DonationHistorySuccess() => _HistoryContent(
                  histories: state.page.data,
                  isLoadingMore: state.isLoadingMore,
                  totalCount: state.page.totalCount,
                  onNearBottom: context.read<DonationHistoryCubit>().loadMore,
                ),
                DonationHistoryEmpty() => const DonationHistoryEmptyState(),
                DonationHistoryError() => _HistoryErrorState(
                  message: state.error.getAllErrorMessages(),
                  onRetry: context.read<DonationHistoryCubit>().loadHistory,
                ),
              };
            },
          ),
        ),
      ),
    );
  }

  static final List<DonationHistoryEntity> _placeholderHistories = [
    DonationHistoryEntity(
      acceptanceId: 'placeholder-1',
      requestId: 'request-1',
      hospitalName: 'Irbid Hospital',
      bloodType: BloodType.AB_Negative,
      date: DateTime.now(),
      status: DonationStatus.Fulfilled,
      pointsEarned: 50,
    ),
    DonationHistoryEntity(
      acceptanceId: 'placeholder-2',
      requestId: 'request-2',
      hospitalName: 'Amman Medical Center',
      bloodType: BloodType.AB_Negative,
      date: DateTime.now(),
      status: DonationStatus.CancelledByDonor,
      pointsEarned: 0,
    ),
  ];
}

class _HistoryContent extends StatelessWidget {
  const _HistoryContent({
    required this.histories,
    required this.isLoadingMore,
    required this.totalCount,
    required this.onNearBottom,
  });

  final List<DonationHistoryEntity> histories;
  final bool isLoadingMore;
  final int totalCount;
  final VoidCallback onNearBottom;

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(10),
                Text(
                  'Donation History',
                  style: context.textStyles.font20TextPrimaryBold,
                ),
                verticalSpace(6),
                Text(
                  '$totalCount records',
                  style: context.textStyles.font14TextPlaceHolderRegular,
                ),
                verticalSpace(20),
              ],
            ),
          ),
          SliverList.separated(
            itemCount: histories.length,
            separatorBuilder: (context, index) => verticalSpace(14),
            itemBuilder: (context, index) {
              return DonationHistoryCard(history: histories[index]);
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

class _HistoryErrorState extends StatelessWidget {
  const _HistoryErrorState({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: context.textStyles.font14TextPrimaryRegular,
            ),
            verticalSpace(18),
            AppElevatedButton(
              isLoading: false,
              onPressed: onRetry,
              title: context.localizations.retry,
            ),
          ],
        ),
      ),
    );
  }
}
