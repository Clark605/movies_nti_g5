import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movies/core/theme/app_theme.dart';
import 'package:movies/features/app_section/view/app_section.dart';
import 'package:movies/features/details/view/screens/details_screen.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
    ),
  );
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
      initialRoute: DetailsScreen.routeName,
      routes: {
        AppSection.routeName: (context) => const AppSection(),
        DetailsScreen.routeName: (context) =>
            const DetailsScreen(movieId: 8197),
      },
    );
  }
}
