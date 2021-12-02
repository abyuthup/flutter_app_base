import 'package:get/get.dart';

import 'package:flutter_baseapp/app/modules/main/bindings/main_binding.dart';
import 'package:flutter_baseapp/app/modules/main/views/main_view.dart';
import 'package:flutter_baseapp/app/modules/profile/bindings/profile_binding.dart';
import 'package:flutter_baseapp/app/modules/profile/views/profile_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.MAIN;

  static final routes = [
    GetPage(
      name: _Paths.MAIN,
      page: () => MainView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
  ];
}
