import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/features/details/view/widgets/movie_details_widget.dart';
import 'package:movies/features/details/view/widgets/sliver_app_bar_widget.dart';
import 'package:movies/features/details/view_model/details_cubit.dart';
import 'package:movies/features/details/view_model/details_state.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});
  static const String routeName = '/details';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBarWidget(),
          SliverFillRemaining(
            child: BlocBuilder(
              bloc: DetailsCubit()..fetchDetails(1426968),
              builder: (context, state) {
                if (state is DetailsSuccess) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
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
                      ),
                    ],
                  );
                }
                if (state is DetailsError) {
                  return Center(child: Text(state.errorMessage));
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [CircularProgressIndicator()],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
