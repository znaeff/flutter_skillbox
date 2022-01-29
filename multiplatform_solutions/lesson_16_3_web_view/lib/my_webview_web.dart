// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:ui' as ui;
import 'package:flutter/widgets.dart';

class MyWebView extends StatelessWidget {
  final String url;

  const MyWebView({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String id = url;
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
        id, (int viewId) => html.IFrameElement()..src = url);
    // ignore: avoid_unnecessary_containers
    return Container(child: HtmlElementView(viewType: id));
  }
}
