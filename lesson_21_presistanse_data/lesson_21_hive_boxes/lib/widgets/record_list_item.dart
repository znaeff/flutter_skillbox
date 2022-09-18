import 'package:flutter/material.dart';
import 'package:lesson_21_hive_boxes/models/record.dart';
import 'record_item_page.dart';

class RecordListItem extends StatelessWidget {
  final String catTitle;
  final Record record;
  final Function(Record) callbackDelete;

  const RecordListItem({
    Key? key,
    required this.catTitle,
    required this.record,
    required this.callbackDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).pushNamed(RecordItemPage.routeName,
            arguments: {'cat_title': catTitle, 'record': record});
      },
      title: Text(
        record.title,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      trailing: IconButton(
        icon: const Icon(
          Icons.delete,
          color: Colors.red,
        ),
        onPressed: () => callbackDelete(record),
      ),
    );
  }
}
