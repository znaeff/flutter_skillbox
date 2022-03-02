import 'package:flutter/services.dart';

import '../platform_service.dart';

class PlatformServiceImpl implements PlatformService {
  static const platform = MethodChannel("CHANNEL_4_SWAP");
  static const stream = EventChannel("EVENTS_4_SWAP");

  @override
  Future<String> getText() async {
    try {
      return await platform.invokeMethod("getText");
    } on PlatformException {
      return '';
    } on MissingPluginException {
      return '';
    }
  }

  @override
  Future<void> setText(String text) async {
    try {
      return await platform.invokeMethod("setText", text);
    } on PlatformException {
      return;
    } on MissingPluginException {
      return;
    }
  }

  @override
  Stream<int> getStream() =>
      stream.receiveBroadcastStream().map((event) => event as int);
}
