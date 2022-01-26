import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';

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

class _MyHomePageState extends State<MyHomePage> {
  String _webUrl = 'https://cleantalk.org';

  String _htmlText = '';
  String? _htmlTitle = '';
  String? _htmlCors = '';
  final TextEditingController _controllerEdit = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controllerEdit.text = _webUrl;
  }

  Future<void> _loadHtmlPage() async {
    final result = await http.get(Uri.parse(_webUrl));
    if (result.statusCode == 200) {
      setState(() {
        _htmlText = result.body;
        _htmlCors = result.headers['access-control-allow-origin'];
        dom.Document doc = parse(result.body);
        _htmlTitle = doc.getElementsByTagName("title").first.innerHtml.trim();
      });
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$_htmlTitle",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              _htmlText == ""
                  ? ""
                  : "CORS : " + (_htmlCors == null ? "none" : "$_htmlCors"),
              style: const TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: SingleChildScrollView(
                  child: Text(_htmlText),
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
                      onSubmitted: (s) {
                        setState(() {
                          _webUrl = s;
                        });
                        _loadHtmlPage();
                      },
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _webUrl = _controllerEdit.text;
                    });
                    _loadHtmlPage();
                  },
                  child: const Text('LOAD'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
