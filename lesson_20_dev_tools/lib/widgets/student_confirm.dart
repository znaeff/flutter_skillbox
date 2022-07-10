import 'dart:async';

import 'package:flutter/cupertino.dart';

final _fakeController = StreamController<int>();

class StudentConfirm extends CupertinoActionSheet {
  Stream<int> get fakeStream => _fakeController.stream;
  //@override
  //void dispose() {
  //  _fakeController.close();
  //}

  const StudentConfirm({Key? key, Text? title, List<Widget>? actions})
      : super(key: key, title: title, actions: actions);
}
