import 'package:custom_roadmap/bloc/roadmap%20element/roadmap_element_state.dart';
import 'package:custom_roadmap/bloc/roadmap/roadmap_state.dart';
import 'package:custom_roadmap/bloc/summary%20roadmap/summary_roadmap_state.dart';
import 'package:custom_roadmap/bloc/theme/theme_state.dart';
import 'package:custom_roadmap/pages/about_roadmap_element_page.dart';
import 'package:custom_roadmap/pages/home_page.dart';
import 'package:custom_roadmap/pages/roadmap_page.dart';
import 'package:custom_roadmap/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()),
        BlocProvider<RoadmapCubit>(create: (_) => RoadmapCubit()),
        BlocProvider<RoadmapElementCubit>(create: (_) => RoadmapElementCubit()),
        BlocProvider<SummaryRoadmapCubit>(create: (_) => SummaryRoadmapCubit()),
      ],
      child: MyApp(
        sharedPreferences: prefs,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;

  const MyApp({super.key, required this.sharedPreferences});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          theme: state.darkTheme == false ? lightTheme : darkTheme,
          home: const HomePage(),
          routes: {
            "/homePage": (context) => const HomePage(),
            "/roadmapPage": (context) => const RoadmapPage(),
            "/aboutRoadmapElementPage": (context) =>
                const AboutRoadmapElementPage(),
          },
        );
      },
    );
  }
}
