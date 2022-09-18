import 'package:hive/hive.dart';

part "record.g.dart";

@HiveType(typeId: 1)
class Record extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String catId;

  @HiveField(2)
  String title;

  @HiveField(3)
  String body;

  Record(this.id, this.catId, this.title, this.body);
}
