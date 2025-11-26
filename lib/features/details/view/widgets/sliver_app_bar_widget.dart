import 'package:flutter/material.dart';
import 'package:movies/core/theme/app_colors.dart';

class SliverAppBarWidget extends StatelessWidget {
  const SliverAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text('Details', style: Theme.of(context).textTheme.titleLarge),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: AppColors.titleText),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.bookmark_border_outlined,
            color: AppColors.titleText,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
