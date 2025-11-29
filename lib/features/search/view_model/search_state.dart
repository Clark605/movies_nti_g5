import 'package:movies/features/search/data/models/movie_model.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<Results> movies;

  SearchSuccess({required this.movies});
}

class SearchError extends SearchState {
  final String errorMessage;

  SearchError({required this.errorMessage});
}

class SearchEmpty extends SearchState {}
