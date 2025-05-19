import 'package:web/web.dart';

import 'package:ongi_app/src/shared/utils/web_back/web_back_stub.dart';

WebBackStub getInstance() => WebBackWeb();

/// A web implementation of the VideoThumbnailPlatform of the VideoThumbnail plugin.
class WebBackWeb implements WebBackStub {
  WebBackWeb();

  @override
  void back() {
    window.history.back();
  }
}
