import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lesson_21_hive_boxes/data/hive_storage.dart';
import 'package:lesson_21_hive_boxes/models/record.dart';
import 'package:lesson_21_hive_boxes/widgets/record_list_item.dart';

class RecordListPage extends StatefulWidget {
  static const routeName = '/record_list';
  final String title;
  final String catId;

  const RecordListPage({Key? key, required this.title, required this.catId})
      : super(key: key);

  @override
  State<RecordListPage> createState() => _RecordListPageState();
}

class _RecordListPageState extends State<RecordListPage> {
  void callbackRecordDelete(Record rec) {
    HiveStorage().deleteRecord(rec.id);
  }

  @override
  Widget build(BuildContext context) {
    Box<Record>? recordBox = HiveStorage().getRecordBox();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: recordBox == null
            ? const CircularProgressIndicator()
            : ValueListenableBuilder(
                valueListenable: recordBox.listenable(),
                builder: (context, Box<Record> box, _) {
                  List<Record> filteredList = box.values
                      .where((element) => element.catId == widget.catId)
                      .toList();
                  return ListView.builder(
                    itemCount: filteredList.length,
                    itemBuilder: ((context, index) {
                      Record record = filteredList.elementAt(index);
                      return RecordListItem(
                        catTitle: widget.title,
                        record: record,
                        callbackDelete: callbackRecordDelete,
                      );
                    }),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _displayTextInputDialog(context),
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }

  final TextEditingController _textTitleController = TextEditingController();
  final TextEditingController _textBodyController = TextEditingController();

  void _displayTextInputDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Add a Record'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: 'Title'),
                  onSubmitted: (s) {
                    if (s != "") {
                      HiveStorage()
                          .addRecord(widget.catId, s, _textBodyController.text);
                    }
                    _textTitleController.text = "";
                    _textBodyController.text = "";
                    Navigator.pop(context);
                  },
                  controller: _textTitleController,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Body'),
                  minLines: 3,
                  maxLines: 3,
                  onSubmitted: (s) {
                    String title = _textTitleController.text;
                    if (title != "") {
                      HiveStorage().addRecord(widget.catId, title, s);
                    }
                    _textTitleController.text = "";
                    _textBodyController.text = "";
                    Navigator.pop(context);
                  },
                  controller: _textBodyController,
                ),
              ],
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              ElevatedButton(
                child: const Text('OK'),
                onPressed: () {
                  String title = _textTitleController.text;
                  if (title != "") {
                    HiveStorage().addRecord(
                        widget.catId, title, _textBodyController.text);
                  }
                  _textTitleController.text = "";
                  _textBodyController.text = "";
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}
