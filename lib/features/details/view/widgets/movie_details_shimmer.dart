import 'package:flutter/material.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MovieDetailsShimmer extends StatelessWidget {
  const MovieDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: Column(
        spacing: 16,
        children: [
          SizedBox(
            height: 300,
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: double.infinity,
                    height: 210,
                    decoration: BoxDecoration(
                      color: AppColors.grey,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    spacing: 12,
                    children: [
                      Container(
                        width: 95,
                        height: 120,
                        decoration: BoxDecoration(
                          color: AppColors.grey,
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 8,
                        children: [
                          Container(width: 200, height: 20, color: Colors.grey),
                          Container(width: 150, height: 16, color: Colors.grey),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 12,
            children: [
              Container(width: 80, height: 16, color: AppColors.grey),
              Text('|'),
              Container(width: 80, height: 16, color: AppColors.grey),
              Text('|'),
              Container(width: 80, height: 16, color: AppColors.grey),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              spacing: 8,
              children: [
                Container(
                  width: double.infinity,
                  height: 14,
                  color: AppColors.grey,
                ),
                Container(
                  width: double.infinity,
                  height: 14,
                  color: AppColors.grey,
                ),
                Container(
                  width: double.infinity,
                  height: 14,
                  color: AppColors.grey,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: 14,
                  color: AppColors.grey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
