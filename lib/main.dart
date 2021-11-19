import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'Utils/themes.dart';
import 'app/routes/app_pages.dart';
import 'generated/l10n.dart';


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

  @override
  void initState() {
    currentTheme.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Application",
      debugShowCheckedModeBanner: false,
      locale: Get.deviceLocale,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        S.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: whiteThemeData(context),
      darkTheme: darkThemeData(context),
      themeMode: currentTheme.currentTheme(),
    );

  }
}



