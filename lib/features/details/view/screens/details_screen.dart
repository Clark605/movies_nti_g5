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

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key, required this.movieId});
  static const String routeName = '/details';

  final int movieId;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late final DetailsCubit _detailsCubit;

  @override
  void initState() {
    super.initState();
    _detailsCubit = DetailsCubit()..fetchDetails(widget.movieId);
  }

  @override
  void dispose() {
    _detailsCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DetailsCubit, DetailsState>(
        bloc: _detailsCubit,
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              if (state is DetailsSuccess)
                SliverAppBarWidget(
                  movieId: widget.movieId,
                  title: state.movieDetails!.title,
                  posterPath: state.movieDetails!.posterPath,
                  releaseDate: state.movieDetails!.releaseDate,
                  voteAverage: state.movieDetails!.voteAverage?.toDouble(),
                  runtime: state.movieDetails!.runtime,
                  genre: state.movieDetails!.genres?.isNotEmpty == true
                      ? state.movieDetails!.genres![0].name
                      : 'Unknown',
                )
              else
                const SliverAppBarWidget(),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    if (state is DetailsSuccess)
                      MovieDetailsWidget(
                        bgUrl: state.movieDetails!.backdropPath ?? '',
                        posterUrl: state.movieDetails!.posterPath ?? '',
                        title: state.movieDetails!.title ?? '',
                        rating: state.movieDetails!.voteAverage!.toDouble(),
                        year: state.movieDetails!.releaseDate ?? '',
                        duration:
                            state.movieDetails!.runtime?.toString() ?? '0',
                        genre: state.movieDetails!.genres![0].name ?? '',
                        description: state.movieDetails!.overview ?? '',
                      )
                    else if (state is DetailsError)
                      Center(child: Text(state.errorMessage))
                    else
                      const MovieDetailsShimmer(),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: BlocBuilder(
                    bloc: SimilarCubit()..fetchSimilarMovies(widget.movieId),
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
          );
        },
      ),
    );
  }
}
