import 'package:flutter/material.dart';
import 'package:flutter_baseapp/app/modules/home/views/wave_slider.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: WaveSlider(
            width: 350,
            height: 50,
          ),
        ),
      ),
    );
  }
}





