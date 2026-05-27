import 'package:donor_app/core/helpers/extensions.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class VersionFooterWithMottoText extends StatelessWidget {
  const VersionFooterWithMottoText({super.key});

  Future<String> getVersionInfo() async {
    final info = await PackageInfo.fromPlatform();

    return info.version;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: FutureBuilder(
          future: getVersionInfo(),
          builder: (context, snapshot) {
            final version = snapshot.data ?? '1.0.0';
            return Text(
              '${context.localizations.app_version} $version • ${context.localizations.app_build}',
              textAlign: TextAlign.center,
              style: context.textStyles.font12TextSecondaryRegular.copyWith(
                letterSpacing: 0,
              ),
            );
          },
        ),
      ),
    );
  }
}
