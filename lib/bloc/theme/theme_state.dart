import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part './theme_cubit.dart';

class ThemeState {
  final bool darkTheme;

  ThemeState({required this.darkTheme});

  ThemeState copyWith({bool? darkTheme}) {
    return ThemeState(darkTheme: darkTheme ?? this.darkTheme);
  }
}
