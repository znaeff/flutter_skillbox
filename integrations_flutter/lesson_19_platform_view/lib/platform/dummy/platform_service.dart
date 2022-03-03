import '../platform_service.dart';

class PlatformServiceImpl implements PlatformService {
  @override
  Future<String> getText() async {
    return ('');
  }

  @override
  Future<void> setText(String text) async {
    return;
  }

  @override
  Stream<int> getStream() => const Stream<int>.empty();
}
