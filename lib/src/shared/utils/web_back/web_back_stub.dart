import 'package:ongi/src/shared/utils/web_back/web_back_helper.dart'
    if (dart.library.js_interop) 'package:ongi/src/shared/utils/web_back/web_back_web.dart'
    if (dart.library.io) 'package:ongi/src/shared/utils/web_back/web_back_io.dart';

abstract class WebBackStub {
  void back();
  factory WebBackStub() => getInstance();
}
