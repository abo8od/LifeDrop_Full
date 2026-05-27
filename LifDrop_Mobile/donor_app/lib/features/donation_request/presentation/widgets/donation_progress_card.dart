import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:donor_app/features/donation_request/presentation/widgets/title_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DonationProgressCard extends StatefulWidget {
  const DonationProgressCard({
    super.key,
    required this.confirmedDonors,
    required this.totalDonors,
  });
  final int confirmedDonors;
  final int totalDonors;

  @override
  State<DonationProgressCard> createState() => _DonationProgressCardState();
}

class _DonationProgressCardState extends State<DonationProgressCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _animation = Tween<double>(
      begin: 0,
      end: widget.confirmedDonors / widget.totalDonors,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: context.colors.navigationBar,
      ),
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 32.h),
      child: Column(
        children: [
          const TitleSection(),
          verticalSpace(16),
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return LinearProgressIndicator(
                value: _animation.value,
                color: context.colors.primary,
                minHeight: 12,
                borderRadius: BorderRadius.circular(30),
              );
            },
          ),
          verticalSpace(16),
          Text(
            context.localizations.urgent_Donors_needed_message(
              widget.totalDonors - widget.confirmedDonors,
            ),
            style: context.textStyles.font14TextSecondaryRegular,
          ),
        ],
      ),
    );
  }
}
