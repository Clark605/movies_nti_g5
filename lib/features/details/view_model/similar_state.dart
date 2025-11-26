import 'package:movies/features/details/data/models/similar_movies_model.dart';

class SimilarState {}

class SimilarInitial extends SimilarState {}

class SimilarLoading extends SimilarState {}

class SimilarSuccess extends SimilarState {
  final SimilarMoviesModel? similarMovies;
  SimilarSuccess(this.similarMovies);
}

class SimilarError extends SimilarState {
  final String errorMessage;
  SimilarError(this.errorMessage);
}
