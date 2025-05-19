import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ongi_app/src/core/constants/app_privacy_source.dart';
import 'package:ongi_app/src/core/extensions/app_loacalizations_context.dart';
import 'package:ongi_app/src/shared/widgets/web_back_button.dart';

class AppPrivacyScreen extends StatelessWidget {
  const AppPrivacyScreen({super.key, required this.languageCode});

  final String languageCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.privacyPolicy),
        automaticallyImplyLeading: kIsWeb ? false : true,
        leading: kIsWeb ? const WebBackButton() : null,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Text(switch (languageCode) {
          'en' => AppPrivacySource.en,
          'ko' => AppPrivacySource.ko,
          'es' => AppPrivacySource.es,
          'ja' => AppPrivacySource.ja,
          'zh' => AppPrivacySource.zh,
          _ => AppPrivacySource.en,
        }),
      ),
    );
  }
}
