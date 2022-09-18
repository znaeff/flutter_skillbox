import 'package:flutter/material.dart';
import 'package:lesson_21_hive_boxes/models/category.dart';
import 'package:lesson_21_hive_boxes/widgets/record_list_page.dart';

class CategoryListItem extends StatelessWidget {
  final Category category;
  final Function(Category) callbackDelete;

  const CategoryListItem({
    Key? key,
    required this.category,
    required this.callbackDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).pushNamed(RecordListPage.routeName,
            arguments: {'cat_id': category.id, 'cat_title': category.name});
      },
      title: Text(
        category.name,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      trailing: IconButton(
        icon: const Icon(
          Icons.delete,
          color: Colors.red,
        ),
        onPressed: () => callbackDelete(category),
      ),
    );
  }
}
