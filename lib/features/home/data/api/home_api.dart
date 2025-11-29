import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies/core/constants/app_constants.dart';
import 'package:movies/core/network/result_api.dart';
import 'package:movies/features/home/data/models/popular_model.dart';
import 'package:movies/features/home/data/models/recommended_model.dart';

abstract class HomeApi {
  // Fetch Popular Movies
  static Future<ResultApi<PopularMoviesModel>> fetchPopularMovies() async {
    Uri url = Uri.https(
      AppConstants.baseUrl,
      '/3/movie/popular',
      {"api_key": AppConstants.apiKey},
    );

    try {
      var response = await http.get(url);
      
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        var data = PopularMoviesModel.fromJson(json);
        return Success<PopularMoviesModel>(data: data);
      } else {
        return Error<PopularMoviesModel>(
          errorMessage: 'Failed to load popular movies',
        );
      }
    } catch (e) {
      return Error<PopularMoviesModel>(
        errorMessage: e.toString(),
      );
    }
  }

  // Fetch Recommended Movies
  static Future<ResultApi<RecommendedMoviesModel>> fetchRecommendedMovies() async {
    Uri url = Uri.https(
      AppConstants.baseUrl,
      '/3/movie/top_rated',
      {"api_key": AppConstants.apiKey},
    );

    try {
      var response = await http.get(url);
      
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        var data = RecommendedMoviesModel.fromJson(json);
        return Success<RecommendedMoviesModel>(data: data);
      } else {
        return Error<RecommendedMoviesModel>(
          errorMessage: 'Failed to load recommended movies',
        );
      }
    } catch (e) {
      return Error<RecommendedMoviesModel>(
        errorMessage: e.toString(),
      );
    }
  }
}