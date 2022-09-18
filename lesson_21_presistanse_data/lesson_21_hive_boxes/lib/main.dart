import 'package:flutter/material.dart';
import 'package:lesson_21_hive_boxes/data/hive_storage.dart';
import 'package:lesson_21_hive_boxes/widgets/category_list_page.dart';
import 'package:lesson_21_hive_boxes/widgets/record_item_page.dart';
import 'package:lesson_21_hive_boxes/widgets/record_list_page.dart';

Future<void> main() async {
  await HiveStorage().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hive Boxes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case RecordListPage.routeName:
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(builder: (BuildContext context) {
              return RecordListPage(
                catId: args['cat_id'],
                title: args['cat_title'],
              );
            });
          case RecordItemPage.routeName:
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(builder: (BuildContext context) {
              return RecordItemPage(
                title: args['cat_title'],
                record: args['record'],
              );
            });
          default:
            return MaterialPageRoute(builder: (BuildContext context) {
              return const CategoryListPage(title: 'Hive Boxes');
            });
        }
      },
    );
  }
}
