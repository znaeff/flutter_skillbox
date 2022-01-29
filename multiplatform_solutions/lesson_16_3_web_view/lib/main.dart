import 'package:flutter/material.dart';
import 'app_platform.dart';
import 'my_webview.dart'
    if (dart.library.io) "my_webview_nonweb.dart"
    if (dart.library.html) "my_webview_web.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum CustomPlatformType { undefined, mobile, desktop, web }

class _MyHomePageState extends State<MyHomePage> {
  static const String webUrlHome = 'https://flutter.dev';

  String _webUrl = webUrlHome;

  final String _htmlTitle = '';
  final TextEditingController _controllerEdit = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controllerEdit.text = _webUrl;
  }

  void _setWebUrl(String url) {
    if (url != _webUrl) {
      setState(() {
        _webUrl = url;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_webUrl),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _htmlTitle,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: MyWebView(
                  url: _webUrl,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      controller: _controllerEdit,
                      onSubmitted: (s) => _setWebUrl(s),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    _setWebUrl(_controllerEdit.text);
                  },
                  child: const Text('LOAD'),
                ),
              ],
            ),
            Column(
              children: [
                Text("App is running on " + AppPlatform.platfromReadable),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
