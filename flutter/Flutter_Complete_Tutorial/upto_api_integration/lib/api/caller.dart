import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tutorial_first_project/helper/manual_debug.dart';
import './constant.dart';

class ApiCaller {
  static Future<String> get callGetApi async {
    final _response = await http.get(Uri.parse(API.getApiEndPoint));

    if (_response.statusCode == 200) {
      Logging.info(
          'Response body: ${_response.body}\nType: ${_response.body.runtimeType}');

      return _response.body;
    }

    return 'Error in get api call';
  }

  static Future<Map<String, dynamic>> get callPostApi async {
    final _url = API.postApiEndPoint("Hello@2023",
        category: 'Mobile_App_Dev', topic: 'Flutter', lang: 'Dart');

    Logging.info('Url is: $_url');

    final _response = await http
        .post(Uri.parse(_url), body: {'name': 'Samarpan', 'time': '23:53'});

    Map<String, dynamic> _responseData = {};

    if (_response.statusCode == 200) {
      Logging.info(
          'Response body: ${_response.body}\nType: ${_response.body.runtimeType}');

      final _decodedData = json.decode(_response.body);

      _responseData['status'] = true;
      _responseData['data'] = _decodedData;
    } else {
      _responseData['status'] = false;
    }

    return _responseData;
  }

  static Future<String> get callUpdateApi async {
    final _response = await http.put(Uri.parse(API.putApiEndPoint));

    if (_response.statusCode == 200) {
      return json.decode(_response.body)['message'] ?? '';
    }

    return 'Error in put api call';
  }

  static Future<String> get callDeleteApi async {
    final _response = await http.delete(Uri.parse(API.deleteApiEndPoint));

    if (_response.statusCode == 200) {
      return json.decode(_response.body)['message'] ?? '';
    }

    return 'Error in delete api call';
  }
}
