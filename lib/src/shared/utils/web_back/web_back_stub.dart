import 'package:ongi_app/src/shared/utils/web_back/web_back_helper.dart'
    if (dart.library.js_interop) 'package:ongi_app/src/shared/utils/web_back/web_back_web.dart'
    if (dart.library.io) 'package:ongi_app/src/shared/utils/web_back/web_back_io.dart';

abstract class WebBackStub {
  void back();
  factory WebBackStub() => getInstance();
}
