import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies/core/constants/app_assets.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/features/search/view_model/search_cubit.dart';

class TextFormFeildWidget extends StatelessWidget {
  const TextFormFeildWidget({
    super.key,
    required TextEditingController searchController,
    required SearchCubit searchCubit,
  }) : _searchController = searchController,
       _searchCubit = searchCubit;

  final TextEditingController _searchController;
  final SearchCubit _searchCubit;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _searchController,
      onChanged: (value) {
        _searchCubit.searchMovies(value);
      },
      style: const TextStyle(color: AppColors.titleText),
      decoration: InputDecoration(
        hintText: 'Search for movies...',
        hintStyle: TextStyle(color: AppColors.grey.withOpacity(0.6)),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SvgPicture.asset(
            AppAssets.searchBarIcon,
            colorFilter: ColorFilter.mode(AppColors.grey, BlendMode.srcIn),
          ),
        ),
        suffixIcon: _searchController.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear, color: AppColors.grey),
                onPressed: () {
                  _searchController.clear();
                  _searchCubit.clearSearch();
                },
              )
            : null,
        filled: true,
        fillColor: AppColors.grey.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }
}
