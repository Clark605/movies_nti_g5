import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movies/core/theme/app_theme.dart';
import 'package:movies/features/app_section/view/app_section.dart';
import 'package:movies/features/details/view/screens/details_screen.dart';
import 'package:movies/features/watchlist/data/models/watchlist_movie_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(WatchlistMovieAdapter());
  await Hive.openBox<WatchlistMovieModel>('watchlist');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.appTheme,
      themeMode: ThemeMode.light,
      initialRoute: AppSection.routeName,
      routes: {
        AppSection.routeName: (context) => const AppSection(),
        // For testing purpose, using a fixed movieId
        // In real app, this should be navigated with actual movieId
        DetailsScreen.routeName: (context) =>
            const DetailsScreen(movieId: 8197),
      },
    );
  }
}
