import 'package:ongi/src/shared/utils/web_back/web_back_stub.dart';

WebBackStub getInstance() => const WebBackIo();

class WebBackIo implements WebBackStub {
  const WebBackIo();

  @override
  void back() {}
}
