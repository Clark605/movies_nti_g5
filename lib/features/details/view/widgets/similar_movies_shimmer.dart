import 'package:flutter/material.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SimilarMoviesShimmer extends StatelessWidget {
  const SimilarMoviesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: SizedBox(
        height: 280,
        child: GridView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 8,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.6,
          ),
          itemBuilder: (context, index) => Container(
            decoration: BoxDecoration(
              color: AppColors.grey,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ),
    );
  }
}
