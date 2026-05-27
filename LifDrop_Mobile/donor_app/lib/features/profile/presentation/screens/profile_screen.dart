import 'package:donor_app/core/enums/blood_type.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:donor_app/features/profile/domain/entities/user_entity.dart';
import 'package:donor_app/features/profile/presentation/logic/profile/profile_cubit.dart';
import 'package:donor_app/features/profile/presentation/logic/profile/profile_state.dart';
import 'package:donor_app/features/profile/presentation/widgets/profile/account_links_section.dart';
import 'package:donor_app/features/profile/presentation/widgets/profile/cooldown_card.dart';
import 'package:donor_app/features/profile/presentation/widgets/profile/identity_sub_grid.dart';
import 'package:donor_app/features/profile/presentation/widgets/profile/profile_header_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 15.h),
            child: BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const SizedBox.shrink(),
                  loading: () => Skeletonizer(
                    enabled: true,
                    child: _buildProfileContent(null),
                  ),
                  success: (user) => _buildProfileContent(user),
                  updating: (user) => _buildProfileContent(user),
                  updateSuccess: (user, response) => _buildProfileContent(user),
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

  Widget _buildProfileContent(UserEntity? user) {
    return Column(
      children: [
        ProfileHeaderSection(
          isVerified: user?.isMedicallyVerified ?? false,
          firstName: user?.firstName ?? 'First',
          lastName: user?.lastName ?? 'Last',
          bloodType: user?.bloodType ?? BloodType.A_Negative,
          governorateName: user?.governorateName ?? 'governorate',
          districtName: user?.districtName ?? 'district',
        ),
        verticalSpace(28),
        const CooldownCard(),
        verticalSpace(24),
        IdentitySubGrid(
          points: user?.gamificationPoints ?? 0,
          totalDonations: user?.totalDonations ?? 0,
        ),
        verticalSpace(24),
        AccountLinksSection(user: user),
      ],
    );
  }
}
