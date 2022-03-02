import '../platform_service.dart';

import 'web_interop.dart';

class PlatformServiceImpl implements PlatformService {
  final _manager = InteropManager();

  @override
  Future<String> getText() async {
    return _manager.getTextFromJs();
  }

  @override
  Future<void> setText(String text) async {
    _manager.setTextToJs(text);
    return;
  }

  @override
  Stream<int> getStream() => _manager.buttonClicked;
}
