import 'package:flutter/material.dart';
import 'package:ongi/src/core/constants/app_constants.dart';
import 'package:ongi/src/core/extensions/app_loacalizations_context.dart';

class AppInformationScreen extends StatelessWidget {
  const AppInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final thisYear = DateTime.now().year;
    final legalese = '© $thisYear $appCreator';
    return LicensePage(
      applicationName: context.loc.appName,
      applicationLegalese: legalese,
      applicationVersion: appVersion,
    );
  }
}
