import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../../config/key_collection.dart';
import '../constant.dart';

class SearchApis {
  static onImageSearch(String query,
      {int pageIndex = 1, int totalItemsPerPage = 15}) async {
    final url =
        '${API.baseUrl}/${API.searchUrl}?${API.queryParam}=$query&${API.perPageParam}=$totalItemsPerPage&${API.pageParam}=$pageIndex';

    debugPrint(url);

    final _response = await http.get(Uri.parse(url), headers: {
      "Accept": "application/json",
      "Authorization": "Bearer ${dotenv.env[KeyCollection.pixelsApiKey]}"
    });

    return json.decode(_response.body);
  }
}
