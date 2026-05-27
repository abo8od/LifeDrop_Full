import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:donor_app/core/widgets/app_header.dart';
import 'package:donor_app/features/home/domain/entities/donation_request_entity.dart';
import 'package:donor_app/features/home/presentation/widgets/request_cards_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActiveRequestsScreen extends StatelessWidget {
  const ActiveRequestsScreen({
    super.key,
    required this.requests,
    required this.canDonate,
  });
  final List<DonationRequestEntity> requests;
  final bool canDonate;

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
              style: context.textStyles.font20TextPrimaryBold.copyWith(
                letterSpacing: -0.5,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: RequestCardsList(
                    requests: requests,
                    canScroll: true,
                    canDonate: canDonate,
                  ),
                ),
              ),
            ),
            verticalSpace(20),
          ],
        ),
      ),
    );
  }
}
