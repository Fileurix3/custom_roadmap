part of 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(darkTheme: false)) {
    _loadTheme();
  }

  void toggleTheme() {
    final newTheme = !state.darkTheme;
    _saveTheme(newTheme);
    emit(ThemeState(darkTheme: newTheme));
  }

  Future<void> _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final darkTheme = prefs.getBool("darkTheme") ?? false;
    emit(ThemeState(darkTheme: darkTheme));
  }

  Future<void> _saveTheme(bool darkTheme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("darkTheme", darkTheme);
  }
}
