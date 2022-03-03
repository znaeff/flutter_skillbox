import 'package:flutter/material.dart';

import 'ffi_bridge.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FFI example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'FFI example'),
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
  late int _textFlutterLen;
  final TextEditingController _controllerEdit = TextEditingController();
  final _ffiBridge = FFIBridge();

  @override
  void initState() {
    super.initState();
    _controllerEdit.text = "Знаев";
    _textFlutterLen = getCSize(_controllerEdit.text);
  }

  int getCSize(String text) {
    try {
      return _ffiBridge.getCSize(text);
    } catch (e) {
      return -1;
    }
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
            TextField(
              controller: _controllerEdit,
              onSubmitted: (s) {
                setState(() {
                  _textFlutterLen = getCSize(s);
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const Divider(),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _textFlutterLen = getCSize(_controllerEdit.text);
                });
              },
              child: const Text('Get length'),
            ),
            const Divider(),
            Text("Lenght is $_textFlutterLen bytes."),
          ],
        ),
      ),
    );
  }
}
