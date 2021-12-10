import 'package:flutter/material.dart';
import 'package:flutter_architecture/data/style_service.dart';
import 'package:flutter_architecture/model/style_data.dart';

class MyStyleService implements StyleService {
  static const List<StyleData> _styles = [
    StyleData(size: 16.0, color: Colors.black),
    StyleData(size: 16.0, color: Colors.red),
    StyleData(size: 14.0, color: Colors.green),
    StyleData(size: 18.0, color: Colors.blue),
    StyleData(size: 12.0, color: Colors.cyan),
  ];

  @override
  StyleData getRandomStyle({int position = 0}) {
    return _styles[position % _styles.length];
  }
}
