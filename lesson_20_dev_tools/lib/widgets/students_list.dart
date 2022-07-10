import 'package:flutter/material.dart';
import 'package:lesson_20_dev_tools/models/student.dart';
//import 'package:lesson_20_dev_tools/widgets/student_details.dart';
import 'package:lesson_20_dev_tools/widgets/student_item.dart';

class StudentList extends StatelessWidget {
  final List<Student> students;
  final Function(Student) activistChanged;

  const StudentList({
    required this.students,
    required this.activistChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: students.length,
      itemBuilder: (BuildContext context, int index) {
        final student = students[index];

        return StudentItem(
          student: student,
          onTap: () => activistChanged(student),
        );
      },
    );
  }
}
