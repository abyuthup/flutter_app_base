
import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SliderWidget(widgetWidth: 300.0, widgetHeight: 1000.0),
    );
  }
}

class SliderWidget extends StatefulWidget {
  final double widgetWidth, widgetHeight;

  SliderWidget({required this.widgetWidth, required this.widgetHeight});

  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget>
    with SingleTickerProviderStateMixin {
  var dragPosition = Offset(0.0, 0.0);
  late AnimationController _controller;
  late Animation animation;
  double animationBeginValue = 0;
  double animationEndValue = 1;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    _controller.addListener(() {
      setState(() {
        debugPrint("animation value ${animation.value}");
      });
    });
    initAnimation();
    _controller.forward();
  }

  void initAnimation() {
    animation =
        Tween<double>(begin: animationBeginValue, end: animationEndValue)
            .animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: (){
        initAnimation();
        _controller.reset();
        _controller.forward();
      },
      child: Container(
        width: widget.widgetWidth,
        height: widget.widgetHeight,
        child: CustomPaint(
          painter: SliderPainter(progress: animation.value*360),
        ),
      ),
    );
  }
}

class SliderPainter extends CustomPainter {
  final double progress;
  Paint sliderPaint = Paint()
    ..style = PaintingStyle.stroke
    // ..strokeCap=StrokeCap.round
    ..strokeWidth = 1
    ..color = Colors.blue;

  SliderPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {

    double rectWidth=min(size.width,size.height);

    Rect rect =Rect.fromCenter(center: Offset(size.width/2,size.height/2), width: rectWidth, height: rectWidth);

    var startAngle=0.0;
    var sweepAngle=progress*pi/180;
    canvas.drawArc(rect, startAngle, sweepAngle, true, sliderPaint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
