import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> fetchFileFromNetwork(String url) async {
  Uri myUri;

  try {
    myUri = Uri.parse(url);
  } catch (e) {
    return '';
  }

  try {
    http.Response response = await http.get(myUri);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return '';
    }
  } catch (e) {
    return '';
  }
}

class NetworkDataJson {
  static const String badData = 'Malformed JSON string';
  static dynamic data;
  static String error = '';

  static get(String urlJson) async {
    String datastring = await fetchFileFromNetwork(urlJson);
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
