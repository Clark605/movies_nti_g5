import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies/core/constants/app_assets.dart';
import 'package:movies/core/constants/app_constants.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/features/search/data/models/movie_model.dart';

class SearchMovieItem extends StatelessWidget {
  const SearchMovieItem({super.key, required this.movie, required this.onTap});

  final Results movie;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Movie Poster
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: movie.posterPath != null
                    ? '${AppConstants.imageBaseUrl}${movie.posterPath}'
                    : AppConstants.placeholderImage,
                width: 95,
                height: 120,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  width: 95,
                  height: 120,
                  color: AppColors.grey.withOpacity(0.3),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.secondaryColor,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  width: 95,
                  height: 120,
                  color: AppColors.grey.withOpacity(0.3),
                  child: const Icon(
                    Icons.movie,
                    color: AppColors.grey,
                    size: 40,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Movie Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    movie.title ?? 'Unknown Title',
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),

                  // Rating
                  Row(
                    children: [
                      SvgPicture.asset(
                        AppAssets.starIcon,
                        width: 16,
                        height: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        movie.voteAverage?.toStringAsFixed(1) ?? 'N/A',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.orange,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Release Year
                  if (movie.releaseDate != null &&
                      movie.releaseDate!.isNotEmpty)
                    Row(
                      children: [
                        SvgPicture.asset(
                          AppAssets.calendarIcon,
                          width: 16,
                          height: 16,
                          colorFilter: const ColorFilter.mode(
                            AppColors.grey,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          movie.releaseDate!.split('-')[0],
                          style: Theme.of(context).textTheme.bodySmall,
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
