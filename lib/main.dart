import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_storage/get_storage.dart';
import 'Helpers/config.dart';
import 'Screens/Drawer/drawer_screen.dart';
import 'Screens/Settings/settings_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  await GetStorage.init();
  Paint.enableDithering = true; //for smooth gradient
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 // Locale _locale = const Locale('en', 'ml');
  GetStorage? prefs;

  @override
  void initState() {
    super.initState();
    prefs = GetStorage();
/*    const String lang = 'English';
    final Map<String, String> codes = {
      'English': 'en',
      'Malayalam': 'ml',
    };
    _locale = Locale(codes[lang]!);*/
    currentTheme.addListener(() {
      setState(() {});
    });
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.black38,

        // systemNavigationBarContrastEnforced: false,
        // systemNavigationBarIconBrightness:
        //     Theme.of(context).brightness == Brightness.dark
        //         ? Brightness.light
        //         : Brightness.dark,
      ),
    );
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return MaterialApp(
      title: 'BaseApp',
     // locale: _locale,
      // restorationScopeId: 'blackhole',
      debugShowCheckedModeBanner: false,
      themeMode: currentTheme.currentTheme(),
      theme: whiteThemeData(),
      darkTheme: darkThemeData(),
      localizationsDelegates: const [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English,
        Locale('ml', ''), // Malayalam
      ],
      routes: {
        '/': (context) =>const DrawerPage(),
        '/setting': (context) => const SettingPage(),
      },
      /*onGenerateRoute: (RouteSettings settings) {
        return HandleRoute().handleRoute(settings.name);
      },*/
    );
  }

  ThemeData whiteThemeData() {
   return ThemeData(
      textSelectionTheme: TextSelectionThemeData(
        selectionHandleColor: currentTheme.currentColor(),
        cursorColor: currentTheme.currentColor(),
        selectionColor: currentTheme.currentColor(),
      ),
      inputDecorationTheme: InputDecorationTheme(
        focusedBorder: UnderlineInputBorder(
          borderSide:
          BorderSide(width: 1.5, color: currentTheme.currentColor()),
        ),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: AppBarTheme(
        backgroundColor: currentTheme.currentColor(),
      ),
      disabledColor: Colors.grey[600],
      brightness: Brightness.light,
      indicatorColor: currentTheme.currentColor(),
      progressIndicatorTheme: const ProgressIndicatorThemeData()
          .copyWith(color: currentTheme.currentColor()),
      iconTheme: IconThemeData(
        color: Colors.grey[800],
        opacity: 1.0,
        size: 24.0,
      ),
      colorScheme: Theme.of(context).colorScheme.copyWith(
        primary: Colors.grey[800],
        brightness: Brightness.light,
        secondary: currentTheme.currentColor(),
      ),
    );
  }

  ThemeData darkThemeData() {
    return ThemeData(
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          primary: Colors.white,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(
        selectionHandleColor: currentTheme.currentColor(),
        cursorColor: currentTheme.currentColor(),
        selectionColor: currentTheme.currentColor(),
      ),
      inputDecorationTheme: InputDecorationTheme(
        focusedBorder: UnderlineInputBorder(
          borderSide:
          BorderSide(width: 1.5, color: currentTheme.currentColor()),
        ),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.dark,
      appBarTheme: AppBarTheme(
        backgroundColor: currentTheme.currentColor(),
        // color: currentTheme.getCanvasColor(),
        foregroundColor: Colors.white,
      ),
      canvasColor: currentTheme.getCanvasColor(),
      cardColor: currentTheme.getCardColor(),
      dialogBackgroundColor: currentTheme.getCardColor(),
      progressIndicatorTheme: const ProgressIndicatorThemeData()
          .copyWith(color: currentTheme.currentColor()),
      iconTheme: const IconThemeData(
        color: Colors.white,
        opacity: 1.0,
        size: 24.0,
      ),
      indicatorColor: currentTheme.currentColor(),
      colorScheme: Theme.of(context).colorScheme.copyWith(
        primary: Colors.white,
        secondary: currentTheme.currentColor(),
        brightness: Brightness.dark,
      ),
    );
  }
}
