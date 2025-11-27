import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies/core/common/widgets/movie_poster.dart';
import 'package:movies/core/constants/app_assets.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/features/watchlist/data/models/watchlist_movie_model.dart';

class MovieItem extends StatelessWidget {
  const MovieItem({
    super.key,
    required this.movie,
    required this.onTap,
    required this.onDelete,
  });

  final WatchlistMovieModel movie;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                    movie.title,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 14),
                  Row(
                    spacing: 4,
                    children: [
                      SvgPicture.asset(
                        AppAssets.starIcon,
                        width: 16,
                        height: 16,
                      ),
                      Text(
                        movie.voteAverage.toStringAsFixed(1),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.orange,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: 4,
                    children: [
                      SvgPicture.asset(
                        AppAssets.calendarIcon,
                        width: 16,
                        height: 16,
                      ),
                      Text(
                        movie.releaseDate.split('-').first,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  Row(
                    spacing: 4,
                    children: [
                      SvgPicture.asset(
                        AppAssets.clockIcon,
                        width: 16,
                        height: 16,
                      ),
                      Text(
                        '${movie.runtime} min',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  Row(
                    spacing: 4,
                    children: [
                      SvgPicture.asset(
                        AppAssets.ticketIcon,
                        width: 16,
                        height: 16,
                      ),
                      Expanded(
                        child: Text(
                          movie.genre,
                          style: Theme.of(context).textTheme.bodyMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: onDelete,
              icon: const Icon(Icons.delete_outline, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
