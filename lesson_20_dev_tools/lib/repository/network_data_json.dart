import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> fetchFileFromNetwork(String url) async {
  Uri myUri;

  try {
    myUri = Uri.parse(url);
  } catch (e) {
    return '';
  }

  http.Response response = await http.get(myUri);
  if (response.statusCode == 200) {
    try {
      return response.body;
    } catch (e) {
      return '';
    }
  } else {
    return '';
  }
}

class NetworkDataJson {
  static const String badData = 'Malformed JSON string';
  static dynamic data;
  static String error = '';
  static const String urlPersonsJson =
      'https://github.com/znaeff/flutter_skillbox/blob/master/lesson_20_dev_tools/assets/json/persons.json';

  static get(String urlPersonsJson) async {
    String datastring = await fetchFileFromNetwork(urlPersonsJson);
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
