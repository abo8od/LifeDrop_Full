import 'package:donor_app/core/enums/blood_type.dart';
import 'package:donor_app/core/enums/urgency_status.dart';
import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:donor_app/core/widgets/app_header.dart';
import 'package:donor_app/features/all_requests/domain/entities/donation_request_feed_entity.dart';
import 'package:donor_app/features/all_requests/presentation/logic/all_requests_cubit.dart';
import 'package:donor_app/features/all_requests/presentation/logic/all_requests_state.dart';
import 'package:donor_app/features/all_requests/presentation/widgets/all_requests_content.dart';
import 'package:donor_app/features/all_requests/presentation/widgets/all_requests_error_state.dart';
import 'package:donor_app/features/all_requests/presentation/widgets/all_requests_filters.dart';
import 'package:donor_app/features/requests/presentation/logic/active_donation/active_donation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AllRequestsScreen extends StatefulWidget {
  const AllRequestsScreen({
    super.key,
    this.activeDonationCubit,
    required this.canDonate,
  });

  final ActiveDonationCubit? activeDonationCubit;
  final bool canDonate;

  @override
  State<AllRequestsScreen> createState() => _AllRequestsScreenState();
}

class _AllRequestsScreenState extends State<AllRequestsScreen> {
  final TextEditingController _searchController = TextEditingController();
  int? _selectedUrgency;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _applyFilters() {
    context.read<AllRequestsCubit>().loadRequests(
      searchTerm: _searchController.text,
      urgency: _selectedUrgency,
    );
  }

  void _selectUrgency(int? urgency) {
    if (_selectedUrgency == urgency) return;
    setState(() => _selectedUrgency = urgency);
    _applyFilters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppHeader(
              icon: IconButton(
                onPressed: context.pop,
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: context.colors.textPrimary,
                  size: 20.sp,
                ),
              ),
              title: context.localizations.active_requests,
              style: context.textStyles.font20TextPrimaryBold,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    AllRequestsFilters(
                      controller: _searchController,
                      selectedUrgency: _selectedUrgency,
                      onSearch: _applyFilters,
                      onUrgencySelected: _selectUrgency,
                    ),
                    verticalSpace(16),
                    Expanded(
                      child: BlocBuilder<AllRequestsCubit, AllRequestsState>(
                        builder: (context, state) {
                          return state.when(
                            initial: () => const SizedBox.shrink(),
                            loading: () => Skeletonizer(
                              child: AllRequestsContent(
                                requests: _placeholderRequests,
                                isLoadingMore: false,
                                totalCount: 10,
                                onNearBottom: () {},
                                canDonate: false,
                                activeDonationCubit: widget.activeDonationCubit,
                              ),
                            ),
                            success:
                                (page, searchTerm, urgency, isLoadingMore) =>
                                    AllRequestsContent(
                                      requests: page.data,
                                      isLoadingMore: isLoadingMore,
                                      totalCount: page.totalCount,
                                      canDonate: widget.canDonate,
                                      onNearBottom: context
                                          .read<AllRequestsCubit>()
                                          .loadMore,
                                      activeDonationCubit:
                                          widget.activeDonationCubit,
                                    ),
                            empty: (searchTerm, urgency) => Center(
                              child: Text(
                                context.localizations.no_active_requests_found,
                                textAlign: TextAlign.center,
                                style:
                                    context.textStyles.font14TextPrimaryRegular,
                              ),
                            ),
                            error: (error) => AllRequestsErrorState(
                              message: error.getAllErrorMessages(),
                              onRetry: _applyFilters,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static final List<DonationRequestFeedEntity> _placeholderRequests = [
    DonationRequestFeedEntity(
      requestId: 'placeholder-1',
      hospitalName: 'Irbid Hospital',
      governorateName: 'Irbid',
      requiredBloodType: BloodType.A_Negative,
      targetQuota: 6,
      remainingQuota: 6,
      urgency: UrgencyStatus.Critical,
      expiryDate: DateTime.now(),
      distancePriority: 1,
      hospitalLatitude: 1,
      hospitalLongitude: 1,
    ),
    DonationRequestFeedEntity(
      requestId: 'placeholder-2',
      hospitalName: 'Amman Hospital',
      governorateName: 'Amman',
      requiredBloodType: BloodType.O_Positive,
      targetQuota: 4,
      remainingQuota: 2,
      urgency: UrgencyStatus.Urgent,
      expiryDate: DateTime.now(),
      distancePriority: 2,
      hospitalLatitude: 1,
      hospitalLongitude: 1,
    ),
  ];
}
