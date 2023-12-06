import 'package:famibo/settings/settings_model.dart';
import 'package:famibo/settings/settings_view.dart';

class SettingsControllerImplementation extends SettingsController{
  SettingsControllerImplementation() : super(const SettingsModel(isDarkMode: false));
  
  @override
  void updateDarkMode({required bool isDarkMode}) {
state = state.copyWith(isDarkMode: isDarkMode);
  }
}