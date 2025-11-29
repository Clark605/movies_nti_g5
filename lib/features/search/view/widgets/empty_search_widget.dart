import 'package:flutter/material.dart';
import 'package:movies/core/constants/app_assets.dart';

class SearchEmptyWidget extends StatelessWidget {
  const SearchEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppAssets.emptySearch, width: 200, height: 200),

          const SizedBox(height: 16),
          Text(
            'we are sorry, we can not find the movie :(',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Find your movie by Type title, categories, years, etc ',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
