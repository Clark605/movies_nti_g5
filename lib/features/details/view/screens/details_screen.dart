import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/features/details/view/widgets/movie_details_shimmer.dart';
import 'package:movies/features/details/view/widgets/movie_details_widget.dart';
import 'package:movies/features/details/view/widgets/similar_movies_shimmer.dart';
import 'package:movies/features/details/view/widgets/similar_movies_widget.dart';
import 'package:movies/features/details/view/widgets/sliver_app_bar_widget.dart';
import 'package:movies/features/details/view_model/details_cubit.dart';
import 'package:movies/features/details/view_model/details_state.dart';
import 'package:movies/features/details/view_model/similar_cubit.dart';
import 'package:movies/features/details/view_model/similar_state.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.movieId});
  static const String routeName = '/details';

  final int movieId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBarWidget(),
          SliverToBoxAdapter(
            child: Column(
              children: [
                BlocBuilder(
                  bloc: DetailsCubit()..fetchDetails(movieId),
                  builder: (context, state) {
                    if (state is DetailsSuccess) {
                      return MovieDetailsWidget(
                        bgUrl: state.movieDetails!.backdropPath ?? '',
                        posterUrl: state.movieDetails!.posterPath ?? '',
                        title: state.movieDetails!.title ?? '',
                        rating: state.movieDetails!.voteAverage!.toDouble(),
                        year: state.movieDetails!.releaseDate ?? '',
                        duration:
                            state.movieDetails!.runtime?.toString() ?? '0',
                        genre: state.movieDetails!.genres![0].name ?? '',
                        description: state.movieDetails!.overview ?? '',
                      );
                    }
                    if (state is DetailsError) {
                      return Center(child: Text(state.errorMessage));
                    }
                    return const MovieDetailsShimmer();
                  },
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: BlocBuilder(
                bloc: SimilarCubit()..fetchSimilarMovies(movieId),
                builder: (context, state) {
                  if (state is SimilarSuccess) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 5,
                      children: [
                        Text(
                          'Similar movies',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        SimilarMoviesWidget(
                          similarMovies: state.similarMovies!.results!,
                          onMovieTap: (movieId) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailsScreen(movieId: movieId),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  }
                  if (state is SimilarError) {
                    return Center(child: Text(state.errorMessage));
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 5,
                    children: [
                      Text(
                        'Similar movies',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SimilarMoviesShimmer(),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
