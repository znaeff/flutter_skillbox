import 'package:meta/meta.dart';

@immutable
class Student {
  final int id;
  final String photo;
  final String name;
  final double middle;
  final bool activist;

  const Student(
      {required this.id,
      required this.photo,
      required this.name,
      required this.middle,
      required this.activist});

  Student copyWith(
      {int? id, String? photo, String? name, double? middle, bool? activist}) {
    return Student(
      id: id ?? this.id,
      photo: photo ?? this.photo,
      name: name ?? this.name,
      middle: middle ?? this.middle,
      activist: activist ?? this.activist,
    );
  }

  String get assetName => 'assets/images/$photo';

  Student.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          photo: json['photo'] ?? 'no-image.png',
          name: json['name'] ?? 'no name',
          middle: json['middle'] ?? 0.0,
          activist: json['activist'] ?? false,
        );
}
