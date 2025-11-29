import 'package:hive/hive.dart';

part 'watchlist_movie_model.g.dart';

@HiveType(typeId: 0)
class WatchlistMovieModel extends HiveObject {
  @HiveField(0)
  int movieId;

  @HiveField(1)
  String title;

  @HiveField(2)
  String? posterPath;

  @HiveField(3)
  String releaseDate;

  @HiveField(4)
  double voteAverage;

  @HiveField(5)
  int runtime;

  @HiveField(6)
  String genre;

  WatchlistMovieModel({
    required this.movieId,
    required this.title,
    this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
    required this.runtime,
    required this.genre,
  });
}
