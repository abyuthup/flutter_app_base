import 'dart:math';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ChartWidget(),
      ),
    );
  }
}

class ChartWidget extends StatefulWidget {
  @override
  State<ChartWidget> createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {
  // late List<int> values=List<int>.generate(sliderCount, (int index) => index * index);
  late List<ChartObj> values = [ChartObj(0.1,Colors.red), ChartObj(0.2,Colors.pink), ChartObj(0.3,Colors.green), ChartObj(0.4,Colors.blue)];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: CustomPaint(
        child: Container(
          color: Colors.red,
        ),
        foregroundPainter: ChartPainter(values),
      ),
      onVerticalDragUpdate: (dragDetails){
        
      },
      on
    );
  }
}

var circlePaint = Paint()..color = Colors.white;

class ChartPainter extends CustomPainter {
  List<ChartObj> values;

  ChartPainter(this.values);

  @override
  void paint(Canvas canvas, Size size) {
    Offset center =Offset(size.width/2,size.height/2);
    var diameter=min(size.width,size.height)*0.9;
    var startAngle=0.0;
    Rect rect = Rect.fromCenter(center: center, width: diameter, height: diameter);
    values.forEach((element) {
      var sweepAngle=element.value*360*pi/180;
      circlePaint.color=element.color;
      canvas.drawArc(rect, startAngle, sweepAngle, true, circlePaint);
      startAngle=startAngle+sweepAngle;
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class ChartObj{
  final double value;
  final Color color;
  ChartObj(this.value, this.color);
}
