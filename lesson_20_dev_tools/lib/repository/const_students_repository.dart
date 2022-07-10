import 'package:lesson_20_dev_tools/models/student.dart';
import 'package:lesson_20_dev_tools/repository/students_repository.dart';

class ConstStudentsRepository extends StudentsRepository {
  const ConstStudentsRepository();

  static const _allStudents = <Student>[
    Student(
      id: 0,
      photo: 'male-1000x1000.png',
      name: 'Йонатан Левин',
      middle: 3.9,
      activist: true,
    ),
    Student(
      id: 1,
      photo: 'female-1000x1000.png',
      name: 'Марина Плешкова',
      middle: 4.5,
      activist: false,
    ),
    Student(
      id: 2,
      photo: 'male-1000x1000.png',
      name: 'Александр Денисов',
      middle: 2.8,
      activist: true,
    ),
    Student(
      id: 3,
      photo: 'male-1000x1000.png',
      name: 'Барух Садогурский',
      middle: 2.1,
      activist: true,
    ),
    Student(
      id: 4,
      photo: 'female-1000x1000.png',
      name: 'Giorgio Natili ',
      middle: 3.3,
      activist: true,
    ),
    Student(
      id: 5,
      photo: 'female-1000x1000.png',
      name: 'Светлана Смельчакова',
      middle: 4.8,
      activist: false,
    ),
    Student(
      id: 6,
      photo: 'male-1000x1000.png',
      name: 'Виталий Фридман',
      middle: 3.8,
      activist: true,
    ),
    Student(
      id: 7,
      photo: 'male-1000x1000.png',
      name: 'Борис Бенгус',
      middle: 2.8,
      activist: false,
    ),
    Student(
      id: 8,
      photo: 'male-1000x1000.png',
      name: 'Александр Сорокин',
      middle: 1.8,
      activist: true,
    ),
  ];

  @override
  Future<List<Student>> loadStudents() async {
    // double fakeVar = 0.0;
    // for (var i = 0; i < 1000000; i++) {
    //   fakeVar = i / 1234;
    // }
    return _allStudents;
  }

  @override
  Future<void> saveStudent(Student student) async {
    //Here should be saving item to repository
    return;
  }
}
