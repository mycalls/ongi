import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ongi_app/src/core/providers/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_startup.g.dart';

@Riverpod(keepAlive: true)
FutureOr<void> appStartup(Ref ref) async {
  ref.onDispose(() {
    ref.invalidate(prefsWithCacheProvider);
  });
  await ref.watch(prefsWithCacheProvider.future);
}
