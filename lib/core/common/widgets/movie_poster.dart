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

          imageUrl: posterUrl != null
              ? 'https://image.tmdb.org/t/p/w500/$posterUrl'
              : AppConstants.placeholderImage,
          width: 120,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
