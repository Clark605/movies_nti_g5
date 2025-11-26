import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:movies/core/constants/app_constants.dart';
import 'package:movies/core/network/result_api.dart';
import 'package:movies/features/search/data/models/search_model.dart';

abstract class SearchApi {
  static Future<ResultApi<SearchModel>> fetchSearch(String search) async {
    Uri url = Uri.https(AppConstants.baseUrl, '/search/movie$search', {
      'api_key': AppConstants.apiKey,
      'query': search,
    });
    try {
      final response = await http.get(url);
      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final result = SearchModel.fromJson(json);
        return Success(data: result);
      } else {
        return Error(errorMessage: json['status_message'] ?? 'Unknown error');
      }
    } catch (e) {
      log(e.toString());
      return Error(errorMessage: e.toString());
    }
  }
}
