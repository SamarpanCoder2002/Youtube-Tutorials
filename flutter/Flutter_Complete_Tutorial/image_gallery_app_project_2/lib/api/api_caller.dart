import 'dart:convert';

import 'package:http/http.dart' as http;
import './secret_key.dart';

class ApiCaller {
  static searchImage(String topic) async {
    try {
      final _response = await http.get(
          Uri.parse(
              'https://api.pexels.com/v1/search?query=$topic&per_page=10'),
          headers: {'Accept': 'application/json', 'Authorization': apiKey});

      return json.decode(_response.body);
    } catch (e) {
      return null;
    }
  }
}
