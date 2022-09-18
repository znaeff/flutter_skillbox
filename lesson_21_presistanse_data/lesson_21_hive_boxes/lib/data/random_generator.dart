import 'dart:math';

// ignore: depend_on_referenced_packages
import 'package:crypto/crypto.dart';
import 'dart:convert';

class RandomGenerator {
  final random = Random();
  String getStringId() =>
      sha1.convert(utf8.encode(random.nextDouble().toString())).toString();
}
