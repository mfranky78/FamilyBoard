import 'package:flutter_riverpod/flutter_riverpod.dart';

final darkModeProvider = StateNotifierProvider<DarkModeNotifier, bool>((ref) {
  return DarkModeNotifier();
});

class DarkModeNotifier extends StateNotifier<bool> {
  DarkModeNotifier() : super(false);

  void toggleDarkMode() {
    state = !state;
  }
}