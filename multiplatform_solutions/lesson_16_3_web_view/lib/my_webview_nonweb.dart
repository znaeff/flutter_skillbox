import 'package:flutter/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'app_platform.dart';

class MyWebView extends StatelessWidget {
  final String url;

  const MyWebView({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget resultWidget = const Text("Sorry, use browser");
    if (AppPlatform.isMobile) {
      resultWidget = WebView(
        key: UniqueKey(),
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
        // Не смог прикрутить контроллер красиво, если подскажете, буду рад.
        // onWebViewCreated: (c) {
        //   _controllerWebView = c;
        // },
      );
    }
    return resultWidget;
  }
}
