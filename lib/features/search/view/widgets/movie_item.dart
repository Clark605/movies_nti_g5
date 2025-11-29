import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies/core/common/widgets/movie_poster.dart';
import 'package:movies/core/constants/app_assets.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/features/search/data/models/movie_model.dart';

class SearchMovieItem extends StatelessWidget {
  final Results movie;
  final VoidCallback onTap;

  const SearchMovieItem({super.key, required this.movie, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            MoviePoster(posterUrl: movie.posterPath),
            const SizedBox(width: 12),

            Expanded(
              child: Column(
                spacing: 4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title ?? '',
                    style: Theme.of(context).textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),

                  Row(
                    spacing: 4,
                    children: [
                      SvgPicture.asset(AppAssets.starIcon, width: 16),
                      Text(
                        (movie.voteAverage ?? 0).toStringAsFixed(1),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.orange,
                        ),
                      ),
                    ],
                  ),

                  Row(
                    spacing: 4,
                    children: [
                      SvgPicture.asset(AppAssets.calendarIcon, width: 16),
                      Text(
                        (movie.releaseDate ?? '').split('-').first,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),

                  Row(
                    spacing: 4,
                    children: [
                      SvgPicture.asset(AppAssets.clockIcon, width: 16),
                      Text(
                        '${movie.voteCount ?? 0} minutes',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
