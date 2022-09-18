import 'package:hive_flutter/hive_flutter.dart';
import 'package:lesson_21_hive_boxes/data/random_generator.dart';
import 'package:lesson_21_hive_boxes/models/category.dart';
import 'package:lesson_21_hive_boxes/models/record.dart';

class HiveStorage {
  final RandomGenerator _randomGen = RandomGenerator();
  Box<Category>? _categoryBox;
  Box<Record>? _recordBox;

  static final HiveStorage _instance = HiveStorage._();

  factory HiveStorage() {
    return _instance;
  }

  HiveStorage._();

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(CategoryAdapter());
    Hive.registerAdapter(RecordAdapter());

    await Hive.openBox<Category>('categories')
        .then((value) => _categoryBox = value);
    await Hive.openBox<Record>('records').then((value) => _recordBox = value);
  }

  Box<Category>? getCategoryBox() => _categoryBox;
  Box<Record>? getRecordBox() => _recordBox;

  void addCategory(String name) async {
    _categoryBox?.add(Category(_randomGen.getStringId(), name));
  }

  void deleteCategory(String id) async {
    Category? cat =
        _categoryBox?.values.firstWhere((element) => element.id == id);
    cat?.delete();
    _recordBox
        ?.deleteAll(_recordBox!.keys.where((element) => element.catId == id));
  }

  void addRecord(String catId, String title, String body) async {
    _recordBox?.add(Record(_randomGen.getStringId(), catId, title, body));
  }

  void deleteRecord(String id) async {
    Record? rec = _recordBox?.values.firstWhere((element) => element.id == id);
    rec?.delete();
  }
}
