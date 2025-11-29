import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/theme/app_theme.dart';
import 'package:movies/features/app_section/view/app_section.dart';
import 'package:movies/features/details/view/screens/details_screen.dart';
import 'package:movies/features/details/view_model/details_cubit.dart';
import 'package:movies/features/details/view_model/similar_cubit.dart';
import 'package:movies/features/home/view_model/home_cubit.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => DetailsCubit()),
        BlocProvider(create: (context) => SimilarCubit()),
        BlocProvider(create: (context) => HomeCubit()..fetchHomeData()),
      ],
      child: MaterialApp(
        title: 'Movies App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.appTheme,
        themeMode: ThemeMode.light,
        initialRoute: AppSection.routeName,
        routes: {
          AppSection.routeName: (context) => const AppSection(),
          DetailsScreen.routeName: (context) {
            final movieId = ModalRoute.of(context)?.settings.arguments as int?;
            return DetailsScreen(movieId: movieId ?? 8197);
          },
        },
      ),
    );
  }
}
