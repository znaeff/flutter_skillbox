import 'dart:async';
import 'package:flutter/material.dart';
import 'platform/platform_service.dart';
import 'platform/dummy/platform_widget_button.dart'
    if (dart.library.html) 'platform/web/platform_widget_button.dart'
    if (dart.library.io) 'platform/mobile/platform_widget_button.dart';
import 'platform/dummy/platform_widget_edit.dart'
    if (dart.library.html) 'platform/web/platform_widget_edit.dart'
    if (dart.library.io) 'platform/mobile/platform_widget_edit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Platform view',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Platform view'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final String textFlutter;
  final TextEditingController _controllerEdit = TextEditingController();
  final _service = getPlatformService();
  final _controllerStream = StreamController();

  void _swapTexts() async {
    String buffer = _controllerEdit.text;
    _controllerEdit.text = await _service.getText();
    await _service.setText(buffer);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _controllerEdit.text = "Flutter";
    _controllerStream.addStream(_service.getStream());
    _controllerStream.stream.listen((event) => _swapTexts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const PlatformWidgetEdit(),
            const Divider(),
            const PlatformWidgetButton(),
            const Divider(),
            TextField(
              controller: _controllerEdit,
              onSubmitted: (s) {
                setState(() {
                  textFlutter = s;
                });
                _swapTexts();
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const Divider(),
            ElevatedButton(
              onPressed: _swapTexts,
              child: const Text('... or here'),
            ),
          ],
        ),
      ),
    );
  }
}
