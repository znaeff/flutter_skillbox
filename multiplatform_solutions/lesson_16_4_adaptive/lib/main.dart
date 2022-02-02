import 'package:flutter/material.dart';
import 'package:lesson_16_4_adaptive/views/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adaptive App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeView(
        title: 'Adaptive App',
      ),
    );
  }
}
