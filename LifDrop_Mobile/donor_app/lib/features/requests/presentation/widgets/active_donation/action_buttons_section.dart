import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:donor_app/core/routing/routes.dart';
import 'package:donor_app/core/widgets/app_text_button.dart';
import 'package:donor_app/features/requests/presentation/logic/active_donation/active_donation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class ActionButtonsSection extends StatelessWidget {
  const ActionButtonsSection({
    super.key,
    required this.requestId,
    required this.hospitalPhoneNumber,
  });
  final String requestId;
  final String hospitalPhoneNumber;

  Future<void> _launchCall(String phoneNumber) async {
    final uri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextButton(
          icon: Icon(Icons.phone, color: Colors.white, size: 18.sp),
          buttonText: context.localizations.contact_hospital_button,
          textStyle: context.textStyles.font16WhiteBold,
          onPressed: () {
            _launchCall(hospitalPhoneNumber.formatPhoneNumberJO());
          },
        ),
        verticalSpace(16),
        AppTextButton(
          icon: Icon(
            Icons.cancel_outlined,
            color: context.colors.textSecondary,
            size: 20.sp,
          ),
          buttonText: context.localizations.cancel_donation_button,
          textStyle: context.textStyles.font16TextSecondaryBold,
          backgroundColor: context.colors.surface,
          onPressed: () async {
            final bool shouldRefresh = await context.pushNamed(
              Routes.cancelRequests,
              arguments: {'requestId': requestId},
            );

            if (shouldRefresh && context.mounted) {
              context.read<ActiveDonationCubit>().getCurrentActiveDonation();
            }
          },
        ),
      ],
    );
  }
}
