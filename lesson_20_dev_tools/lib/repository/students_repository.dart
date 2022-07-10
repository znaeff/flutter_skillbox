import 'package:lesson_20_dev_tools/models/student.dart';

abstract class StudentsRepository {
  const StudentsRepository();

  Future<List<Student>> loadStudents();

  Future<void> saveStudent(Student student);
}
