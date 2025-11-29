import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/features/watchlist/data/database/watchlist_database.dart';
import 'package:movies/features/watchlist/view_model/watchlist_state.dart';

class WatchlistCubit extends Cubit<WatchlistState> {
  final WatchlistDatabase _database = WatchlistDatabase();

  WatchlistCubit() : super(WatchlistInitial());

  // Load all watchlist movies
  void loadWatchlist() {
    try {
      emit(WatchlistLoading());
      final movies = _database.getAllWatchlist();
      if (movies.isEmpty) {
        emit(WatchlistEmpty());
      } else {
        emit(WatchlistLoaded(movies));
      }
    } catch (e) {
      emit(WatchlistError(e.toString()));
    }
  }

  // Remove movie from watchlist
  Future<void> removeMovie(int movieId) async {
    try {
      await _database.removeFromWatchlist(movieId);
      loadWatchlist();
    } catch (e) {
      emit(WatchlistError(e.toString()));
    }
  }
}
