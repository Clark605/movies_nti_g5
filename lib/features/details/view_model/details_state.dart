import 'package:movies/features/details/data/models/movie_detail_model.dart';

class DetailsState {}

class DetailsInitial extends DetailsState {}

class DetailsLoading extends DetailsState {}

class DetailsSuccess extends DetailsState {
  final MovieDetailsModel? movieDetails;
  DetailsSuccess(this.movieDetails);
}

class DetailsError extends DetailsState {
  final String errorMessage;
  DetailsError(this.errorMessage);
}
