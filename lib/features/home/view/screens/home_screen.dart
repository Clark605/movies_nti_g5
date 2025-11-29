import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/features/home/view_model/home_cubit.dart';
import 'package:movies/features/home/view_model/home_state.dart';
import 'package:movies/features/home/view/widgets/home_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String routeName = '/home-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.secondaryColor,
                ),
              );
            }

            if (state is HomeError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: AppColors.grey,
                      size: 48,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Error: ${state.errorMessage}',
                      style: const TextStyle(color: AppColors.white),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<HomeCubit>().fetchHomeData();
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            if (state is HomeSuccess) {
              final recommendedMovies = state.recommendedMovies?.results ?? [];
              final popularMovies = state.popularMovies?.results ?? [];

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "What do you want to watch?",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    const SizedBox(height: 24),
                    if (recommendedMovies.isNotEmpty)
                      SizedBox(
                        height: 230,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: recommendedMovies.length > 15
                              ? 15
                              : recommendedMovies.length,
                          itemBuilder: (context, index) {
                            final movie = recommendedMovies[index];
                            return Padding(
                              padding: EdgeInsets.only(right: index == 3 ? 0 : 12),
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  MovieCard(
                                    posterUrl: movie.posterPath,
                                    movieId: movie.id ?? 0,
                                    width: 145,
                                    height: 210,
                                  ),
                                  Positioned(
                                    bottom: -30,
                                    left: -20,
                                    child: Stack(
                                      children: [
                                        Text(
                                          '${index + 1}',
                                          style: TextStyle(
                                            fontSize: 96,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Montserrat',
                                            foreground: Paint()
                                              ..style = PaintingStyle.stroke
                                              ..strokeWidth = 1.2 
                                              ..color = const Color(0xFF0296E5),
                                          ),
                                        ),
                                        Text(
                                          '${index + 1}',
                                          style: TextStyle(
                                            fontSize: 96,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Montserrat',
                                            color: const Color(0xFF242A32),
                                            shadows: [
                                              Shadow(
                                                color: Colors.black26,
                                                offset: const Offset(0, 4),
                                                blurRadius: 4,
                                              ),
                                              Shadow(
                                                color: Colors.black26,
                                                offset: const Offset(0, 4),
                                                blurRadius: 4,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    const SizedBox(height: 32),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "Popular",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (popularMovies.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 12,
                            childAspectRatio: 0.67,
                          ),
                          itemCount:
                              popularMovies.length > 15 ? 15 : popularMovies.length,
                          itemBuilder: (context, index) {
                            final movie = popularMovies[index];
                            return MovieCard(
                              posterUrl: movie.posterPath,
                              movieId: movie.id ?? 0,
                            );
                          },
                        ),
                      ),
                    const SizedBox(height: 32),
                  ],
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
