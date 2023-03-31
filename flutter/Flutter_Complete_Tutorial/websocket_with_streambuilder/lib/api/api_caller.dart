import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiCaller {
  static Future<String> get getData async {
    final _response = await http
        .get(Uri.parse('https://second-service.onrender.com/api/hello'));

    if (_response.statusCode == 200) {
      return _response.body;
    }

    return '';
  }

  static Future<dynamic> postData(String param, String name, String time,
      {required String cat,
      required String topic,
      required String lang}) async {
    final _response = await http.post(
        Uri.parse(
            'https://second-service.onrender.com/api/send-data/$param?cat=$cat&topic=$topic&lang=$lang'),
        body: {'name': name, 'time': time});

    if (_response.statusCode == 200) {
      return json.decode(_response.body);
    }

    return {};
  }

  static Future<dynamic> updateData(String param) async {
    final _response = await http.put(
      Uri.parse('https://second-service.onrender.com/api/update-data/$param'),
    );

    if (_response.statusCode == 200) {
      return json.decode(_response.body);
    }

    return {};
  }

  static Future<dynamic> deleteData(String param) async {
    final _response = await http.delete(
      Uri.parse('https://second-service.onrender.com/api/delete-data/$param'),
    );

    if (_response.statusCode == 200) {
      return json.decode(_response.body);
    }

    return {};
  }
}
