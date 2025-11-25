import 'package:flutter/material.dart';
import 'package:movies/core/common/widgets/movie_poster.dart';
import 'package:movies/core/constants/app_constants.dart';
import 'package:movies/features/details/data/models/similar_movies_model.dart';

class SimilarMoviesWidget extends StatelessWidget {
  const SimilarMoviesWidget({
    super.key,
    required this.similarMovies,
    required this.onMovieTap,
  });
  final List<Results> similarMovies;
  final void Function(int) onMovieTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: similarMovies.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 13,
          crossAxisSpacing: 10,
          childAspectRatio: 1.6,
        ),

        itemBuilder: (context, index) => MoviePoster(
          posterUrl:
              similarMovies[index].posterPath ?? AppConstants.placeholderImage,
          onTap: () => onMovieTap(similarMovies[index].id!),
        ),
      ),
    );
  }
}
