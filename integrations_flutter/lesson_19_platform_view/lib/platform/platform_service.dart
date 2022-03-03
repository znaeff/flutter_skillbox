import 'dummy/platform_service.dart'
    if (dart.library.html) 'web/platform_service.dart'
    if (dart.library.io) 'mobile/platform_service.dart';

abstract class PlatformService {
  Future<String> getText();
  Future<void> setText(String text);
  Stream<int> getStream();
}

PlatformService getPlatformService() {
  return PlatformServiceImpl();
}
