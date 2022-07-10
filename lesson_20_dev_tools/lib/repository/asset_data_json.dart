import 'dart:convert';

import 'package:flutter/services.dart';

Future<String> fetchFileFromAssets(String assetName) async {
  if (assetName == '') {
    return '';
  } else {
    return rootBundle
        .loadString('assets/' + assetName)
        .then((file) => file.toString())
        .onError((error, stackTrace) => '');
  }
}

class AssetsDataJson {
  static const String badData = 'Malformed JSON string';
  static dynamic data;
  static String error = '';

  static get(String assetName) async {
    error = '';
    data = null;
    String datastring = await fetchFileFromAssets(assetName);
    if (datastring != '') {
      try {
        data = json.decode(datastring);
      } catch (e) {
        error = badData;
      }
    } else {
      error = badData;
    }
  }
}
