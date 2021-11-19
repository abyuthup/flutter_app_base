import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.drawerItems[controller.selectedDrawerIndex.value].title),
      ),
      body: Obx(() {
        return controller.getDrawerFragment(controller.selectedDrawerIndex.value);
      }),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            //Lets Create a material design drawer header with account name, email,avatar
            UserAccountsDrawerHeader(
              accountName: Text("Aby"),
              accountEmail: Text("aby***@gmail.com"),
              currentAccountPicture: CircleAvatar(
                radius: 18,
                child: ClipOval(
                  child: Image.network(
                    'https://i.pravatar.cc/300',
                  ),
                ),
              ),
            ),
            Column(children: controller.drawerOptions)
          ],
        ),
      ),
    );
  }
}
