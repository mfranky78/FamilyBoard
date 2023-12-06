import 'package:famibo/settings/darkmode_notifire_riverpod.dart';
import 'package:famibo/settings/settings_contoller.dart';
import 'package:famibo/settings/settings_model.dart';
import 'package:famibo/settings/settings_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Providers providers = Providers();

class Providers {
final settingsProvider = StateNotifierProvider<SettingsController, SettingsModel>((ref) => SettingsControllerImplementation());
}