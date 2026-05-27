import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:donor_app/core/resources/image_paths.dart';
import 'package:donor_app/core/widgets/app_images.dart';
import 'package:donor_app/core/widgets/app_linear_progress.dart';
import 'package:donor_app/features/profile/domain/entities/cooldown_entity.dart';
import 'package:donor_app/features/profile/presentation/logic/cooldown/cooldown_cubit.dart';
import 'package:donor_app/features/profile/presentation/logic/cooldown/cooldown_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CooldownCard extends StatelessWidget {
  const CooldownCard({super.key});

  static const int cooldownPeriodDays = 90;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CooldownCubit, CooldownState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox.shrink(),
          loading: () =>
              _buildCooldownContent(context, CooldownEntity.placeholder()),
          success: (data) => _buildCooldownContent(context, data),
          error: (error) => _buildErrorState(context),
        );
      },
    );
  }

  Widget _buildErrorState(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.navigationBar,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(32.w),
      child: Center(
        child: TextButton.icon(
          onPressed: () => context.read<CooldownCubit>()..getCooldownStatus(),
          icon: const Icon(Icons.refresh),
          label: Text(context.localizations.retry),
        ),
      ),
    );
  }

  Widget _buildCooldownContent(BuildContext context, CooldownEntity data) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.navigationBar,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(32.w),
      child: Stack(
        children: [
          Positioned(
            right: context.isRTL ? null : 0,
            left: context.isRTL ? 0 : null,
            child: AppImages(
              width: 64.w,
              height: 80.h,
              path: ImagePaths.hourglassEmpty,
              type: ImageType.svg,
              color: context.colors.primary.withAlpha(
                context.isDarkMode ? 50 : 25,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: .start,
            children: [
              Text(
                context.localizations.next_eligible_donation,
                style: context.textStyles.font10PrimaryBold.copyWith(
                  letterSpacing: 1,
                ),
              ),
              verticalSpace(16),
              Row(
                crossAxisAlignment: .end,
                children: [
                  Text(
                    data.daysRemaining.toString(),
                    style: context.textStyles.font60TextPrimaryExtraBold,
                  ),
                  horizontalSpace(8),
                  Text(
                    context.localizations.days_label,
                    style: context.textStyles.font24SecondaryBold.copyWith(
                      letterSpacing: 0,
                    ),
                  ),
                ],
              ),
              verticalSpace(16),
              AppLinearProgress(
                value:
                    (cooldownPeriodDays - data.daysRemaining) /
                    cooldownPeriodDays,
                isReverse: true,
                height: 12,
                width: double.infinity,
              ),
              verticalSpace(16),
              Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: context.colors.textSecondary,
                    size: 20,
                  ),
                  horizontalSpace(8),
                  Flexible(
                    child: Text(
                      context.localizations.cooldown_recovery_message,
                      style: context.textStyles.font14TextSecondaryRegular
                          .copyWith(letterSpacing: 0),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
