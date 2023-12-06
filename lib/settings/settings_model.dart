import 'package:freezed_annotation/freezed_annotation.dart';
part 'settings_model.freezed.dart';

@freezed
class SettingsModel with _$SettingsModel {
  const factory SettingsModel({
    required bool isDarkMode,}) = _SettingsModel;}