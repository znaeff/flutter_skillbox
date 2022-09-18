import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lesson_21_hive_boxes/data/hive_storage.dart';
import 'package:lesson_21_hive_boxes/models/category.dart';
import 'package:lesson_21_hive_boxes/widgets/category_list_item.dart';

class CategoryListPage extends StatefulWidget {
  final String title;
  const CategoryListPage({Key? key, required this.title}) : super(key: key);

  @override
  State<CategoryListPage> createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  void callbackCategoryDelete(Category cat) {
    HiveStorage().deleteCategory(cat.id);
  }

  @override
  Widget build(BuildContext context) {
    Box<Category>? categoryBox = HiveStorage().getCategoryBox();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: categoryBox == null
            ? const CircularProgressIndicator()
            : ValueListenableBuilder(
                valueListenable: categoryBox.listenable(),
                builder: (context, Box<Category> box, widget) =>
                    ListView.builder(
                  itemCount: box.length,
                  itemBuilder: ((context, index) {
                    Category item = box.values.elementAt(index);
                    return CategoryListItem(
                        category: item, callbackDelete: callbackCategoryDelete);
                  }),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _displayTextInputDialog(context),
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }

  final TextEditingController _textFieldController = TextEditingController();

  void _displayTextInputDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Add a Category'),
            content: TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              onSubmitted: (s) {
                if (s != "") {
                  HiveStorage().addCategory(s);
                }
                _textFieldController.text = "";
                Navigator.pop(context);
              },
              controller: _textFieldController,
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
                  String s = _textFieldController.text;
                  if (s != "") {
                    HiveStorage().addCategory(s);
                  }
                  _textFieldController.text = "";
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}
