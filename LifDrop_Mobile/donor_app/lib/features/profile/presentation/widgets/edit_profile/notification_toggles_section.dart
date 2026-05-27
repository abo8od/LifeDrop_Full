import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:donor_app/features/profile/presentation/widgets/edit_profile/toggle_row.dart';
import 'package:flutter/material.dart';

class NotificationTogglesSection extends StatelessWidget {
  final ValueNotifier<bool> availableNotifier;
  final ValueNotifier<bool> criticalNotifier;
  final ValueNotifier<bool> urgentNotifier;
  final ValueNotifier<bool> normalNotifier;

  const NotificationTogglesSection({
    super.key,
    required this.availableNotifier,
    required this.criticalNotifier,
    required this.urgentNotifier,
    required this.normalNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ToggleRow(
          icon: Icons.notifications_active_outlined,
          title: context.localizations.available_for_donation,
          notifier: availableNotifier,
        ),
        verticalSpace(16),
        ToggleRow(
          icon: Icons.notifications_active_outlined,
          title: context.localizations.critical_notifications,
          notifier: criticalNotifier,
        ),
        verticalSpace(16),
        ToggleRow(
          icon: Icons.notifications_active_outlined,
          title: context.localizations.urgent_notifications,
          notifier: urgentNotifier,
        ),
        verticalSpace(16),
        ToggleRow(
          icon: Icons.notifications_active_outlined,
          title: context.localizations.normal_notifications,
          notifier: normalNotifier,
        ),
      ],
    );
  }
}
