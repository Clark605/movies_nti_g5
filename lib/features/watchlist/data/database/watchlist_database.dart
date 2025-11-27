import 'package:hive/hive.dart';
import 'package:movies/features/watchlist/data/models/watchlist_movie_model.dart';

class WatchlistDatabase {
  static const String _boxName = 'watchlist';

  // Get the Hive box
  Box<WatchlistMovieModel> get _box => Hive.box<WatchlistMovieModel>(_boxName);

  // Add movie to watchlist
  Future<void> addToWatchlist(WatchlistMovieModel movie) async {
    await _box.put(movie.movieId, movie);
  }

  // Remove movie from watchlist
  Future<void> removeFromWatchlist(int movieId) async {
    await _box.delete(movieId);
  }

  // Get all movies in watchlist
  List<WatchlistMovieModel> getAllWatchlist() {
    return _box.values.toList();
  }

  // Check if movie is in watchlist
  bool isInWatchlist(int movieId) {
    return _box.containsKey(movieId);
  }

  // Get movie by ID
  WatchlistMovieModel? getMovie(int movieId) {
    return _box.get(movieId);
  }
}
