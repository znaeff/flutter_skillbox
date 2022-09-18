import 'package:flutter/material.dart';
import 'package:lesson_21_hive_boxes/models/record.dart';

class RecordItemPage extends StatelessWidget {
  static const routeName = '/record_page';
  final String title;
  final Record record;

  const RecordItemPage({super.key, required this.title, required this.record});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListTile(
                title: Text(record.title),
              ),
              const Divider(
                thickness: 2.0,
                color: Colors.blue,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(record.body),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
