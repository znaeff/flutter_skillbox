import "dart:io";
import 'package:flutter/foundation.dart';

class AppPlatform {
  static const Map<String, CustomPlatform> _platformMap = {
    'android': CustomPlatform.android,
    'ios': CustomPlatform.ios,
    'linux': CustomPlatform.linux,
    'macos': CustomPlatform.macos,
    'windows': CustomPlatform.windows,
    'fuchsia': CustomPlatform.fuchsia,
  };

  static CustomPlatform _getPlatform() {
    if (kIsWeb) {
      return CustomPlatform.web;
    }
    return _platformMap[Platform.operatingSystem] ?? CustomPlatform.undefined;
  }

  static CustomPlatform get platfrom => _getPlatform();

  static String get platfromReadable => platfrom.toString().substring(15);

  static bool get isWeb => platfrom == CustomPlatform.web;

  static bool get isMobile =>
      platfrom == CustomPlatform.android || platfrom == CustomPlatform.ios;

  static bool get isDesktop =>
      platfrom == CustomPlatform.linux ||
      platfrom == CustomPlatform.windows ||
      platfrom == CustomPlatform.macos;
}

enum CustomPlatform {
  undefined,
  android,
  ios,
  linux,
  macos,
  windows,
  fuchsia,
  web,
}
