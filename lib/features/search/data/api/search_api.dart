import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:movies/core/constants/app_constants.dart';
import 'package:movies/core/network/result_api.dart';
import 'package:movies/features/search/data/models/movie_model.dart';

abstract class SearchApi {
  static Future<ResultApi<SearchResponseModel>> searchMovies(
    String query,
  ) async {
    Uri url = Uri.https(AppConstants.baseUrl, '/3/search/movie', {
      'api_key': AppConstants.apiKey,
      'query': query,
    });

    try {
      final response = await http.get(url);
      final json = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final movieModel = SearchResponseModel.fromJson(json);
        return Success(data: movieModel);
      } else {
        return Error(errorMessage: json['status_message'] ?? 'Unknown error');
      }
    } catch (e) {
      log(e.toString());
      return Error(errorMessage: e.toString());
    }
  }
}
