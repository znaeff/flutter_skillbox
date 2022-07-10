//import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lesson_20_dev_tools/models/student.dart';
//import 'package:lesson_20_dev_tools/widgets/student_confirm.dart';
//import 'package:lesson_20_dev_tools/utils/utils.dart';

class StudentItem extends StatelessWidget {
  final GestureTapCallback onTap;
  final Student student;

  const StudentItem({
    Key? key,
    required this.onTap,
    required this.student,
  }) : super(key: key);

  void showConfirm(BuildContext context) {
    //StreamController<int> _fakeController = StreamController<int>();
    //Stream<int> fakeStream = _fakeController.stream;

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
//      builder: (BuildContext context) => StudentConfirm(
        title: const Text(
          'Сменить активиста?',
//            style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: const Text('Да'),
            onPressed: () {
              onTap();
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Нет'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );

    // showDialog<String>(
    //   context: context,
    //   builder: (BuildContext context) => SimpleDialog(
    //     title: const Text('Сменить активиста?'),
    //     children: <Widget>[
    //       SimpleDialogOption(
    //         onPressed: () {
    //           onTap();
    //           Navigator.pop(context);
    //         },
    //         child: const Text('Да'),
    //       ),
    //       SimpleDialogOption(
    //         onPressed: () {
    //           Navigator.pop(context);
    //         },
    //         child: const Text('Нет'),
    //       ),
    //     ],
    //   ),
    // );

    //_fakeController.close();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () => showConfirm(context),
        leading: CircleAvatar(
          backgroundImage: AssetImage(student.assetName),
        ),
        title: Text(
          student.name,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        subtitle: Text('Средний балл ${student.middle}'),
        trailing: Switch(
          dragStartBehavior: DragStartBehavior.down,
          value: student.activist,
          onChanged: (bool newValue) {
            //onTap();
            showConfirm(context);
          },
        ));
  }
}
