import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies/core/constants/app_constants.dart';
import 'package:movies/core/theme/app_colors.dart';

class MoviePoster extends StatelessWidget {
  const MoviePoster({super.key, required this.posterUrl, this.onTap});
  final String? posterUrl;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: CachedNetworkImage(
          placeholder: (context, url) => Container(
            width: 120,
            height: 180,
            color: AppColors.grey.withValues(alpha: 0.5),
          ),
          errorWidget: (context, url, error) => Container(
            width: 120,
            height: 180,
            color: AppColors.grey.withValues(alpha: 0.5),
            child: Icon(Icons.movie, color: AppColors.grey),
          ),
          imageUrl: posterUrl != null && posterUrl!.isNotEmpty
              ? '${AppConstants.imageBaseUrl}$posterUrl'
              : AppConstants.placeholderImage,
          width: 120,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
