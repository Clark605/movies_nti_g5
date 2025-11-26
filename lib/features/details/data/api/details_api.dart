import 'dart:convert';
import 'dart:developer';

import 'package:movies/core/constants/app_constants.dart';
import 'package:movies/core/network/result_api.dart';
import 'package:movies/features/details/data/models/movie_detail_model.dart';
import 'package:http/http.dart' as http;
import 'package:movies/features/details/data/models/similar_movies_model.dart';

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
      log(e.toString());
      return Error(errorMessage: e.toString());
    }
  }

  static Future<ResultApi<SimilarMoviesModel>> fetchSimilarDetails(
    int movieId,
  ) async {
    Uri url = Uri.https(AppConstants.baseUrl, '/3/movie/$movieId/similar', {
      'api_key': AppConstants.apiKey,
    });
    try {
      final response = await http.get(url);
      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final similarMoviesModel = SimilarMoviesModel.fromJson(json);
        return Success(data: similarMoviesModel);
      } else {
        return Error(errorMessage: json['status_message'] ?? 'Unknown error');
      }
    } catch (e) {
      log(e.toString());
      return Error(errorMessage: e.toString());
    }
  }
}
