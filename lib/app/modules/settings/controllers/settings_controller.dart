import 'package:flutter/material.dart';
import 'package:flutter_baseapp/Utils/common_keys.dart';
import 'package:flutter_baseapp/Utils/themes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsController extends GetxController {

  var pref = GetStorage();
  late String theme, themeColor;

  late int colorHue;

  final List<String> colors = [
    'Purple',
    'Deep Purple',
    'Indigo',
    'Blue',
    'Light Blue',
    'Cyan',
    'Teal',
    'Green',
    'Light Green',
    'Lime',
    'Yellow',
    'Amber',
    'Orange',
    'Deep Orange',
    'Red',
    'Pink',
  ];

  void switchToCustomTheme() {
    const custom = 'Custom';
    if (theme != custom) {
      currentTheme.setInitialTheme(custom);
      theme = custom;
    }
  }

  @override
  void onInit() {
    super.onInit();
    theme = (pref.read(key_theme) == null
        ? 'Default'
        : pref.read(key_theme) as String);
    themeColor = (pref.read(key_themeColor) == null)
        ? 'Teal'
        : pref.read(key_themeColor) as String;

    colorHue = (pref.read(key_colorHue) == null)
        ? 400
        : pref.read(key_colorHue) as int;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

}
