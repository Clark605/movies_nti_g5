import 'package:movies/features/home/data/models/popular_model.dart';
import 'package:movies/features/home/data/models/recommended_model.dart';

class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final PopularMoviesModel? popularMovies;
  final RecommendedMoviesModel? recommendedMovies;
  
  HomeSuccess({
    this.popularMovies,
    this.recommendedMovies,
  });
}

class HomeError extends HomeState {
  final String errorMessage;
  HomeError(this.errorMessage);
}