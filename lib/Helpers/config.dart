library config.globals;

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'Common_keys.dart';

class MyTheme with ChangeNotifier {
  GetStorage? prefs;
  late bool _isDark=true, _useSystemTheme=false;
  late int backGradColor=1, cardGradColor=3, bottomGradColor=2, colorHueColor=400;
  late String accentColor='Teal', canvasColor='Grey', cardColor='Grey850';

  MyTheme() {
    prefs = GetStorage();
    RefreshVariables();
  }

  void RefreshVariables() {
    _isDark = (prefs!.read(key_darkMode) == null)
        ? true
        : prefs!.read(key_darkMode) as bool;
    _useSystemTheme = (prefs!.read(key_useSystemTheme) == null)
        ? false
        : prefs!.read(key_useSystemTheme) as bool;
    accentColor = (prefs!.read(key_themeColor) == null)
        ? 'Teal'
        : prefs!.read(key_themeColor) as String;
    canvasColor = (prefs!.read(key_canvasColor) == null)
        ? 'Grey'
        : prefs!.read(key_canvasColor) as String;
    cardColor = (prefs!.read(key_cardColor) == null)
        ? 'Grey850'
        : prefs!.read(key_cardColor) as String;
    backGradColor =(prefs!.read(key_backGradient) == null) ? 1 : prefs!.read(key_backGradient) as int;
    cardGradColor =
        (prefs!.read(key_cardGrad) == null) ? 3 : prefs!.read(key_cardGrad) as int;
    bottomGradColor = (prefs!.read(key_bottomGrad) == null)
        ? 2
        : prefs!.read(key_bottomGrad) as int;
    colorHueColor = (prefs!.read(key_colorHue) == null)
        ? 400
        : prefs!.read(key_colorHue) as int;
  }

  // int backGrad = Hive.box('settings').get('backGrad', defaultValue: 1) as int;
  Color? playGradientColor;

  List<List<Color>> backOpt = [
    [
      Colors.grey[850]!,
      Colors.grey[900]!,
      Colors.black,
    ],
    [
      Colors.grey[900]!,
      Colors.grey[900]!,
      Colors.black,
    ],
    [
      Colors.grey[900]!,
      Colors.black,
    ],
    [
      Colors.grey[900]!,
      Colors.black,
      Colors.black,
    ],
    [
      Colors.black,
      Colors.black,
    ]
  ];

  List<List<Color>> cardOpt = [
    [
      Colors.grey[850]!,
      Colors.grey[850]!,
      Colors.grey[900]!,
    ],
    [
      Colors.grey[850]!,
      Colors.grey[900]!,
      Colors.grey[900]!,
    ],
    [
      Colors.grey[850]!,
      Colors.grey[900]!,
      Colors.black,
    ],
    [
      Colors.grey[900]!,
      Colors.grey[900]!,
      Colors.black,
    ],
    [
      Colors.grey[900]!,
      Colors.black,
    ],
    [
      Colors.grey[900]!,
      Colors.black,
      Colors.black,
    ],
    [
      Colors.black,
      Colors.black,
    ]
  ];

  List<List<Color>> transOpt = [
    [
      Colors.grey[850]!.withOpacity(0.8),
      Colors.grey[900]!.withOpacity(0.9),
      Colors.black.withOpacity(1),
    ],
    [
      Colors.grey[900]!.withOpacity(0.8),
      Colors.grey[900]!.withOpacity(0.9),
      Colors.black.withOpacity(1),
    ],
    [
      Colors.grey[900]!.withOpacity(0.9),
      Colors.black.withOpacity(1),
    ],
    [
      Colors.grey[900]!.withOpacity(0.9),
      Colors.black.withOpacity(0.9),
      Colors.black.withOpacity(1),
    ],
    [
      Colors.black.withOpacity(0.9),
      Colors.black.withOpacity(1),
    ]
  ];

  void refresh() {
    RefreshVariables();
    notifyListeners();
  }

  void switchTheme({bool? useSystemTheme, bool? isDark, bool notify = true}) {
    if (isDark != null) {
      _isDark = isDark;
    }
    if (useSystemTheme != null) {
      _useSystemTheme = useSystemTheme;
    }

    prefs?.write(key_darkMode, _isDark);
    prefs?.write(key_useSystemTheme, _useSystemTheme);
    if (notify) notifyListeners();
  }

  void switchColor(String color, int hue, {bool notify = true}) {
    prefs?.write(key_themeColor, color);
    accentColor = color;
    prefs?.write(key_colorHue, hue);
    colorHueColor = hue;
    if (notify) notifyListeners();
  }

  ThemeMode currentTheme() {
    if (_useSystemTheme == true) {
      return ThemeMode.system;
    } else {
      return _isDark ? ThemeMode.dark : ThemeMode.light;
    }
  }

  int currentHue() {
    return colorHueColor;
  }

  Future<void> setLastPlayGradient(Color? color) async {
    playGradientColor = color;
  }

  Color getColor(String color, int hue) {
    switch (color) {
      case 'Red':
        return Colors.redAccent[hue]!;
      case 'Teal':
        return Colors.tealAccent[hue]!;
      case 'Light Blue':
        return Colors.lightBlueAccent[hue]!;
      case 'Yellow':
        return Colors.yellowAccent[hue]!;
      case 'Orange':
        return Colors.orangeAccent[hue]!;
      case 'Blue':
        return Colors.blueAccent[hue]!;
      case 'Cyan':
        return Colors.cyanAccent[hue]!;
      case 'Lime':
        return Colors.limeAccent[hue]!;
      case 'Pink':
        return Colors.pinkAccent[hue]!;
      case 'Green':
        return Colors.greenAccent[hue]!;
      case 'Amber':
        return Colors.amberAccent[hue]!;
      case 'Indigo':
        return Colors.indigoAccent[hue]!;
      case 'Purple':
        return Colors.purpleAccent[hue]!;
      case 'Deep Orange':
        return Colors.deepOrangeAccent[hue]!;
      case 'Deep Purple':
        return Colors.deepPurpleAccent[hue]!;
      case 'Light Green':
        return Colors.lightGreenAccent[hue]!;
      case 'White':
        return Colors.white;

      default:
        return _isDark ? Colors.tealAccent[400]! : Colors.lightBlueAccent[400]!;
    }
  }

  Color getCanvasColor() {
    if (canvasColor == 'Black') return Colors.black;
    if (canvasColor == 'Grey') return Colors.grey[900]!;
    return Colors.grey[900]!;
  }

  void switchCanvasColor(String color, {bool notify = true}) {
    prefs?.write(key_canvasColor, color);

    canvasColor = color;
    if (notify) notifyListeners();
  }

  Color getCardColor() {
    if (cardColor == 'Grey800') return Colors.grey[800]!;
    if (cardColor == 'Grey850') return Colors.grey[850]!;
    if (cardColor == 'Grey900') return Colors.grey[900]!;
    if (cardColor == 'Black') return Colors.black;
    return Colors.grey[850]!;
  }

  void switchCardColor(String color, {bool notify = true}) {
    prefs?.write(key_cardColor, color);
    cardColor = color;
    if (notify) notifyListeners();
  }

  List<Color> getCardGradient({bool miniplayer = false}) {
    final List<Color> output = cardOpt[cardGradColor];
    if (miniplayer && output.length > 2) {
      output.removeAt(0);
    }
    return output;
  }

  List<Color> getBackGradient() {
    return backOpt[backGradColor];
  }

  Color getPlayGradient() {
    return backOpt[backGradColor].last;
  }

  List<Color> getTransBackGradient() {
    return transOpt[backGradColor];
  }

  List<Color> getBottomGradient() {
    return backOpt[bottomGradColor];
  }

  Color currentColor() {
    switch (accentColor) {
      case 'Red':
        return Colors.redAccent[currentHue()]!;
      case 'Teal':
        return Colors.tealAccent[currentHue()]!;
      case 'Light Blue':
        return Colors.lightBlueAccent[currentHue()]!;
      case 'Yellow':
        return Colors.yellowAccent[currentHue()]!;
      case 'Orange':
        return Colors.orangeAccent[currentHue()]!;
      case 'Blue':
        return Colors.blueAccent[currentHue()]!;
      case 'Cyan':
        return Colors.cyanAccent[currentHue()]!;
      case 'Lime':
        return Colors.limeAccent[currentHue()]!;
      case 'Pink':
        return Colors.pinkAccent[currentHue()]!;
      case 'Green':
        return Colors.greenAccent[currentHue()]!;
      case 'Amber':
        return Colors.amberAccent[currentHue()]!;
      case 'Indigo':
        return Colors.indigoAccent[currentHue()]!;
      case 'Purple':
        return Colors.purpleAccent[currentHue()]!;
      case 'Deep Orange':
        return Colors.deepOrangeAccent[currentHue()]!;
      case 'Deep Purple':
        return Colors.deepPurpleAccent[currentHue()]!;
      case 'Light Green':
        return Colors.lightGreenAccent[currentHue()]!;
      case 'White':
        return Colors.white;

      default:
        return _isDark ? Colors.tealAccent[400]! : Colors.lightBlueAccent[400]!;
    }
  }

  void saveTheme(String themeName) {
    // final userThemes =Hive.box('settings').get('userThemes', defaultValue: {}) as Map;
    final userThemes = (prefs!.read(key_userThemes) == null)
        ? {}
        : prefs!.read(key_userThemes) as Map;

    prefs?.write('userThemes', {
      ...userThemes,
      themeName: {
        'isDark': _isDark,
        'useSystemTheme': _useSystemTheme,
        'accentColor': accentColor,
        'canvasColor': canvasColor,
        'cardColor': cardColor,
        'backGrad': backGradColor,
        'cardGrad': cardGradColor,
        'bottomGrad': bottomGradColor,
        'colorHue': colorHueColor,
      }
    });
  }

  void deleteTheme(String themeName) {
    final userThemes = (prefs!.read(key_userThemes) == null)
        ? {}
        : prefs!.read(key_userThemes) as Map;
    userThemes.remove(themeName);
    prefs?.write(key_userThemes, {...userThemes});
  }

  Map getThemes() {
    return (prefs!.read(key_userThemes) == null)
        ? {}
        : prefs!.read(key_userThemes) as Map;
  }

  void setInitialTheme(String themeName) {
    prefs?.write(key_theme, themeName);
  }

  String? getInitialTheme() {
    return (prefs!.read(key_theme) == null)
        ? null
        : prefs!.read(key_theme) as String;
    // return Hive.box('settings').get('theme') as String;
  }
}

MyTheme currentTheme = MyTheme();
