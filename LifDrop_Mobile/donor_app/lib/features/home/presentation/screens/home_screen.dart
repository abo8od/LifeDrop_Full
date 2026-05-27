import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:donor_app/core/resources/image_paths.dart';
import 'package:donor_app/core/widgets/app_header.dart';
import 'package:donor_app/core/widgets/app_images.dart';
import 'package:donor_app/features/home/domain/entities/home_data_entity.dart';
import 'package:donor_app/features/home/presentation/logic/home_cubit.dart';
import 'package:donor_app/features/home/presentation/logic/home_state.dart';
import 'package:donor_app/features/home/presentation/widgets/biometric_sheet.dart';
import 'package:donor_app/features/home/presentation/widgets/donation_summary.dart';
import 'package:donor_app/features/home/presentation/widgets/greeting_section.dart';
import 'package:donor_app/features/home/presentation/widgets/request_cards_list.dart';
import 'package:donor_app/features/home/presentation/widgets/requests_section.dart';
import 'package:donor_app/features/requests/presentation/logic/active_donation/active_donation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listenWhen: (previous, current) => current is HomeBiometricPromptRequired,
      listener: (context, state) {
        showModalBottomSheet(
          context: context,
          enableDrag: false,
          isDismissible: false,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          backgroundColor: context.colors.background,
          builder: (context) => const BiometricSheet(),
        );
      },
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox.shrink(),
          loading: () => Skeletonizer(
            child: _buildHomeContent(context, HomeDataEntity.placeHolder()),
          ),
          success: (data) => _buildHomeContent(context, data),
          error: (error) => Center(child: Text(error.getAllErrorMessages())),
          biometricPromptRequired: () => const SizedBox.shrink(),
        );
      },
    );
  }

  Widget _buildHomeContent(BuildContext context, HomeDataEntity data) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 24.w, right: 24.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                AppHeader(
                  icon: const AppImages(
                    path: ImagePaths.logo,
                    type: ImageType.svg,
                    width: 16,
                    height: 20,
                  ),
                  title: context.localizations.life_drop,
                  style: context.textStyles.font20PrimaryExtraBold,
                ),
                verticalSpace(15),
                GreetingSection(
                  hospitalName: data.lastHospitalName,
                  username: data.username,
                  remainingDays: data.remainingDays,
                ),
                verticalSpace(18),
                DonationSummary(totalDonations: data.totalContributions),
                verticalSpace(38),
                const RequestsSection(),
                verticalSpace(24),
                RequestCardsList(
                  canDonate: data.canDonate,
                  requests: data.activeRequests,
                  maxVisibleRequests: 5,
                  activeDonationCubit: context.read<ActiveDonationCubit>(),
                ),
                verticalSpace(20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
