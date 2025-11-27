import 'package:movies/features/watchlist/data/models/watchlist_movie_model.dart';

abstract class WatchlistState {}

class WatchlistInitial extends WatchlistState {}

class WatchlistLoading extends WatchlistState {}

class WatchlistLoaded extends WatchlistState {
  final List<WatchlistMovieModel> movies;

  WatchlistLoaded(this.movies);
}

class WatchlistEmpty extends WatchlistState {}

class WatchlistError extends WatchlistState {
  final String message;

  WatchlistError(this.message);
}
