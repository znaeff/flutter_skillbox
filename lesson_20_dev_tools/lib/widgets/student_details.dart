import 'package:flutter/material.dart';
//import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lesson_20_dev_tools/models/student.dart';
//import 'package:lesson_20_dev_tools/utils/utils.dart';

class DetailsScreen extends StatelessWidget {
  final Student student;
  final Function(bool) activistChanged;

  const DetailsScreen({
    required this.student,
    required this.activistChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                child: Image.asset(student.assetName,
                    fit: BoxFit.fitWidth,
                    width: MediaQuery.of(context).size.width),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(
                  top: 40.0,
                ),
                child: Center(
                    child: Text(student.name,
                        style: const TextStyle(
                          fontSize: 30.0,
                        )))),
            Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                    child: Text(student.activist.toString(),
                        style: const TextStyle(
                          fontSize: 20.0,
                        )))),
          ],
        ),
      ),
    );
  }
}
