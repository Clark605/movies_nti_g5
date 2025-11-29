import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/features/details/view/screens/details_screen.dart';
import 'package:movies/features/search/view/widgets/empty_state_widget.dart';
import 'package:movies/features/search/view/widgets/movie_item.dart';
import 'package:movies/features/search/view/widgets/text_form_feild_widget.dart';
import 'package:movies/features/search/view_model/search_cubit.dart';
import 'package:movies/features/search/view_model/search_state.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final SearchCubit _searchCubit = SearchCubit();

  @override
  void dispose() {
    _searchController.dispose();
    _searchCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search', style: Theme.of(context).textTheme.titleLarge),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormFeildWidget(
              searchController: _searchController,
              searchCubit: _searchCubit,
            ),
          ),

          // Search Results
          Expanded(
            child: BlocBuilder<SearchCubit, SearchState>(
              bloc: _searchCubit,
              builder: (context, state) {
                // Initial State
                if (state is SearchInitial) {
                  return EmptyStateWidget();
                }

                // Loading State
                if (state is SearchLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.secondaryColor,
                    ),
                  );
                }

                // Empty State (No Results)
                if (state is SearchEmpty) {
                  return EmptyStateWidget();
                }

                // Error State
                if (state is SearchError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 80,
                          color: AppColors.grey.withOpacity(0.5),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Error: ${state.errorMessage}',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  );
                }

                // Success State (Show Results)
                if (state is SearchSuccess) {
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: state.movies.length,
                    itemBuilder: (context, index) {
                      final movie = state.movies[index];
                      return SearchMovieItem(
                        movie: movie,
                        onTap: () {
                          if (movie.id != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailsScreen(movieId: movie.id!),
                              ),
                            );
                          }
                        },
                      );
                    },
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
