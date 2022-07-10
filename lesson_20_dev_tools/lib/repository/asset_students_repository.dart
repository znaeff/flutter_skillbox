import 'package:lesson_20_dev_tools/models/student.dart';
import 'package:lesson_20_dev_tools/repository/asset_data_json.dart';
import 'package:lesson_20_dev_tools/repository/students_repository.dart';

class AssetStudentsRepository extends StudentsRepository {
  AssetStudentsRepository();

  static const jsonAssetName = 'json/persons.json';

  //List<Student> _allStudents = [];

  @override
  Future<List<Student>> loadStudents() async {
    List<Student> _allStudents = [];
    await AssetsDataJson.get(jsonAssetName);

    if (AssetsDataJson.error == '') {
      try {
        _allStudents = AssetsDataJson.data
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
