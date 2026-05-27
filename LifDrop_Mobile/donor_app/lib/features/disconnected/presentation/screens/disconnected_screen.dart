import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/internet_connection_service.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:donor_app/core/resources/image_paths.dart';
import 'package:donor_app/core/widgets/app_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Screen shown when the app starts without an internet connection.
class DisconnectedScreen extends StatefulWidget {
  const DisconnectedScreen({super.key, this.onReconnect});

  final VoidCallback? onReconnect;

  @override
  State<DisconnectedScreen> createState() => _DisconnectedScreenState();
}

class _DisconnectedScreenState extends State<DisconnectedScreen> {
  final InternetConnectionService _internetConnectionService =
      const InternetConnectionService();
  bool _isChecking = false;

  Future<void> _retryConnection() async {
    setState(() => _isChecking = true);

    final hasConnection = await _internetConnectionService.hasConnection();

    if (!mounted) return;

    setState(() => _isChecking = false);

    if (hasConnection) {
      final onReconnect = widget.onReconnect;
      if (onReconnect != null) {
        onReconnect();
      } else {
        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: widget.onReconnect == null,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 112.r,
                    width: 112.r,
                    decoration: BoxDecoration(
                      color: context.colors.neutral,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      ImagePaths.connectionLostIcon,
                      height: 48.r,
                      width: 48.r,
                      colorFilter: ColorFilter.mode(
                        context.colors.textSecondary,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  verticalSpace(28),
                  Text(
                    context.localizations.no_internet_connection_title,
                    textAlign: TextAlign.center,
                    style: context.textStyles.font24TextPrimaryBold,
                  ),
                  verticalSpace(12),
                  Text(
                    context.localizations.no_internet_connection_message,
                    textAlign: TextAlign.center,
                    style: context.textStyles.font16TextSecondaryRegular,
                  ),
                  verticalSpace(32),
                  AppElevatedButton(
                    isLoading: _isChecking,
                    onPressed: _retryConnection,
                    title: context.localizations.retry,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
