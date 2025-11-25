import 'dart:convert';

import 'package:movies/core/constants/app_constants.dart';
import 'package:movies/core/network/result_api.dart';
import 'package:movies/features/details/data/models/movie_detail_model.dart.dart';
import 'package:http/http.dart' as http;

abstract class DetailsApi {
  static Future<ResultApi<MovieDetailsModel>> fetchMovieDetails(
    int movieId,
  ) async {
    Uri url = Uri.https(AppConstants.baseUrl, '/3/movie/$movieId', {
      'api_key': AppConstants.apiKey,
    });
    try {
      final response = await http.get(url);
      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final movieDetails = MovieDetailsModel.fromJson(json);
        return Success(data: movieDetails);
      } else {
        return Error(errorMessage: json['status_message'] ?? 'Unknown error');
      }
    } catch (e) {
      return Error(errorMessage: e.toString());
    }
  }
}
