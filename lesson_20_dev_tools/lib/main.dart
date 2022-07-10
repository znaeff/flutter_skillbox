import 'package:provider/provider.dart';
import 'package:lesson_20_dev_tools/observables/state_observable.dart';
import 'package:lesson_20_dev_tools/views/home_view.dart';
//import 'package:lesson_20_dev_tools/repository/const_students_repository.dart';
//import 'package:lesson_20_dev_tools/repository/asset_students_repository.dart';
import 'package:lesson_20_dev_tools/repository/network_students_repository.dart';
import 'package:flutter/material.dart';

void main() => runApp(const StudentsMobXApp());

class StudentsMobXApp extends StatelessWidget {
  const StudentsMobXApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) =>
//              StateObservable(const ConstStudentsRepository()),
//              StateObservable(AssetStudentsRepository()),
              StateObservable(NetworkStudentsRepository()),
        )
      ],
      child: const MaterialApp(
        title: 'Students',
        home: HomeView(),
      ),
    );
  }
}
