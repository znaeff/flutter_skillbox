import 'package:lesson_20_dev_tools/models/student.dart';
import 'package:lesson_20_dev_tools/repository/network_data_json.dart';
import 'package:lesson_20_dev_tools/repository/students_repository.dart';

class NetworkStudentsRepository extends StudentsRepository {
  NetworkStudentsRepository();

  static const String jsonNetworkUrl =
      'https://raw.githubusercontent.com/znaeff/flutter_skillbox/b93ff3c19d30d4c89d27ee3d6ef57e38903d1373/lesson_20_dev_tools/assets/json/persons.json';

  @override
  Future<List<Student>> loadStudents() async {
    List<Student> _allStudents = [];
    await NetworkDataJson.get(jsonNetworkUrl);

    if (NetworkDataJson.error == '') {
      try {
        _allStudents = NetworkDataJson.data
            .map<Student>((e) => Student.fromJson(e))
            .toList();
      } catch (e) {
        //_allStudents = [];
      }
    }
    return _allStudents;
  }

  @override
  Future<void> saveStudent(Student student) async {
    //Here should be saving item to repository
    return;
  }
}
