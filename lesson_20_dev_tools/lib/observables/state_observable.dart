import 'package:lesson_20_dev_tools/models/tabs.dart';
import 'package:mobx/mobx.dart';
import 'package:lesson_20_dev_tools/models/student.dart';
import 'package:lesson_20_dev_tools/repository/students_repository.dart';

part 'state_observable.g.dart';

class StateObservable = _StateObservable with _$StateObservable;

abstract class _StateObservable with Store {
  final StudentsRepository _studentsRepository;

  @observable
  List<Student> students = [];

  @observable
  int activeTabIndex = Tabs.all.index;

  @computed
  bool get isLoaded => students.isNotEmpty;

  _StateObservable(this._studentsRepository) {
    _initStudents();
  }

  @computed
  List<Student> get allStudents => students.toList();

  @computed
  List<Student> get activeStudents =>
      students.where((s) => s.activist).toList();

  @action
  Future<void> _initStudents() async {
    students = await _studentsRepository.loadStudents();
  }

  @action
  void updateStudent(Student student) {
    _studentsRepository.saveStudent(student);
    students = students
        .map<Student>((Student s) => s.id == student.id ? student : s)
        .toList();
  }

  @action
  void updateTab(int index) {
    activeTabIndex = index;
  }
}
