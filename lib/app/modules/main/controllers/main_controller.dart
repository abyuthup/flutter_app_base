import 'package:flutter/material.dart';
import 'package:flutter_baseapp/app/data/drawer_item.dart';
import 'package:flutter_baseapp/app/modules/home/views/home_view.dart';
import 'package:flutter_baseapp/app/modules/settings/views/settings_view.dart';
import 'package:flutter_baseapp/generated/l10n.dart';
import 'package:get/get.dart';

class MainController extends GetxController {


  final count = 0.obs;
  final selectedDrawerIndex = 0.obs;
  List<Widget> drawerOptions = [];

  final drawerItems = [
    DrawerItem(S.of(Get.context!).home, Icons.home),
    DrawerItem(S.of(Get.context!).settings, Icons.settings),
  ];


  getDrawerFragment(int pos) {
    switch (pos) {
      case 0:
        return HomeView();
      case 1:
        return SettingsView();
      default:
        return HomeView();
    }
  }


  //Let's update the selectedDrawerItemIndex the close the drawer
  _onSelectItem(int index) {
    selectedDrawerIndex.value = index;
    print(selectedDrawerIndex.value);
    //we close the drawer
    Get.back();
  }



  @override
  void onInit() {
    super.onInit();
    //Let's create drawer list items. Each will have an icon and text
    for (var i = 0; i < drawerItems.length; i++) {
      var d = drawerItems[i];
      drawerOptions.add(
           ListTile(
            leading:  Icon(d.icon),
            title:  Text(d.title),
            selected: i == selectedDrawerIndex,
            onTap: () => _onSelectItem(i),
          )
      );
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;


}
