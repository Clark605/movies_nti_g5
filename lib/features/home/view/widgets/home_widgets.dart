import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies/core/constants/app_constants.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/features/details/view/screens/details_screen.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    super.key,
    required this.posterUrl,
    required this.movieId,
    this.width = 120,
    this.height = 180,
  });

  final String? posterUrl;
  final int movieId;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          DetailsScreen.routeName,
          arguments: movieId,
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: CachedNetworkImage(
          placeholder: (context, url) => Container(
            width: width,
            height: height,
            color: AppColors.grey.withOpacity(0.3),
            child: const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.secondaryColor,
              ),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            width: width,
            height: height,
            color: AppColors.grey.withOpacity(0.3),
            child: const Icon(Icons.movie, color: AppColors.grey),
          ),
          imageUrl: posterUrl != null && posterUrl!.isNotEmpty
              ? '${AppConstants.imageBaseUrl}$posterUrl'
              : AppConstants.placeholderImage,
          width: width,
          height: height,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
