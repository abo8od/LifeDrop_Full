import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:donor_app/core/mixins/snack_bar_mixin.dart';
import 'package:donor_app/core/widgets/app_text_button.dart';
import 'package:donor_app/features/requests/presentation/logic/cancel_donation/cancel_donation_cubit.dart';
import 'package:donor_app/features/requests/presentation/logic/cancel_donation/cancel_donation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CancelButtonsSection extends StatelessWidget with SnackBarMixin {
  const CancelButtonsSection({super.key, required this.onPressed});
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CancelDonationCubit, CancelDonationState>(
      builder: (context, state) {
        final isCancelLoading =
            context.read<CancelDonationCubit>().state is CancelDonationLoading;
        return Column(
          children: [
            AppTextButton(
              buttonText: context.localizations.confirm_cancellation_button,
              textStyle: context.textStyles.font16WhiteBold,
              isLoading: isCancelLoading,
              icon: Icon(
                Icons.check_circle_outline,
                color: Colors.white,
                size: 22.sp,
              ),
              onPressed: isCancelLoading ? () {} : onPressed,
            ),
            verticalSpace(16),
            AppTextButton(
              buttonText: context.localizations.go_back_button,
              textStyle: context.textStyles.font16TextPrimaryBold,
              backgroundColor: context.isDarkMode
                  ? context.colors.surface
                  : Colors.white,
              isLoading: false,
              onPressed: isCancelLoading
                  ? () {}
                  : () {
                      context.pop<bool>(value: false);
                    },
            ),
          ],
        );
      },
    );
  }
}
