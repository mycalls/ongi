import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ongi/src/core/constants/app_terms_source.dart';
import 'package:ongi/src/core/extensions/app_loacalizations_context.dart';
import 'package:ongi/src/shared/widgets/web_back_button.dart';

class AppTermsScreen extends StatelessWidget {
  const AppTermsScreen({super.key, required this.languageCode});

  final String languageCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.termsOfService),
        automaticallyImplyLeading: kIsWeb ? false : true,
        leading: kIsWeb ? const WebBackButton() : null,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Text(switch (languageCode) {
          'en' => AppTermsSource.en,
          'ko' => AppTermsSource.ko,
          'es' => AppTermsSource.es,
          'ja' => AppTermsSource.ja,
          'zh' => AppTermsSource.zh,
          _ => AppTermsSource.en,
        }),
      ),
    );
  }
}
