
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/network/result_api.dart';
import 'package:movies/features/home/data/api/home_api.dart';
import 'package:movies/features/home/data/models/popular_model.dart';
import 'package:movies/features/home/data/models/recommended_model.dart';
import 'package:movies/features/home/view_model/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  PopularMoviesModel? popularMovies;
  RecommendedMoviesModel? recommendedMovies;

  void fetchHomeData() async {
    emit(HomeLoading());

    try {
      // Fetch both popular and recommended movies
      final popularResult = await HomeApi.fetchPopularMovies();
      final recommendedResult = await HomeApi.fetchRecommendedMovies();

      // Handle popular movies
      switch (popularResult) {
        case Success<PopularMoviesModel>():
          popularMovies = popularResult.data;
          break;
        case Error<PopularMoviesModel>():
          emit(HomeError(popularResult.errorMessage));
          return;
      }

      // Handle recommended movies
      switch (recommendedResult) {
        case Success<RecommendedMoviesModel>():
          recommendedMovies = recommendedResult.data;
          break;
        case Error<RecommendedMoviesModel>():
          emit(HomeError(recommendedResult.errorMessage));
          return;
      }

      // Emit success with both data
      emit(HomeSuccess(
        popularMovies: popularMovies,
        recommendedMovies: recommendedMovies,
      ));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
