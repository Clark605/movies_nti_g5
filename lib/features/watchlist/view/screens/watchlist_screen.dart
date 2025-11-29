import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/features/details/view/screens/details_screen.dart';
import 'package:movies/features/watchlist/view/widgets/empty_list_widget.dart';
import 'package:movies/features/watchlist/view/widgets/movie_item.dart';
import 'package:movies/features/watchlist/view_model/watchlist_cubit.dart';
import 'package:movies/features/watchlist/view_model/watchlist_state.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  late WatchlistCubit _watchlistCubit;
  @override
  void initState() {
    super.initState();
    _watchlistCubit = WatchlistCubit();
    _watchlistCubit.loadWatchlist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist', style: Theme.of(context).textTheme.titleLarge),
      ),
      body: BlocBuilder<WatchlistCubit, WatchlistState>(
        bloc: _watchlistCubit,
        builder: (context, state) {
          if (state is WatchlistLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is WatchlistEmpty) {
            return EmptyListWidget();
          }

          if (state is WatchlistError) {
            return Center(
              child: Text(
                state.message,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            );
          }

          if (state is WatchlistLoaded) {
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.movies.length,
              itemBuilder: (context, index) {
                final movie = state.movies[index];
                return MovieItem(
                  movie: movie,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailsScreen(movieId: movie.movieId),
                      ),
                    ).whenComplete(() {
                      _watchlistCubit.loadWatchlist();
                    });
                  },
                  onDelete: () {
                    _watchlistCubit.removeMovie(movie.movieId);
                  },
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
