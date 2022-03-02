import 'package:flutter/material.dart';

class PlatformWidgetButton extends StatelessWidget {
  const PlatformWidgetButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 40,
      width: 200,
      child: Text('Not supported'),
    );
  }
}
