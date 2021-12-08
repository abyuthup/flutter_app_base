
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
      child: SliderWidget(widgetWidth: 300.0, widgetHeight: 300.0),
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
  double animationEndValue = 0;

  bool isDraggng=false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 300));
    _controller.addListener(() {
      setState(() {
        debugPrint("animation value ${animation.value}");
      });
    });
    initAnimation();
  }

  void initAnimation() {
    animation =
        Tween<double>(begin: animationBeginValue, end: animationEndValue)
            .animate(_controller);

  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (dragUpdateDetails) {
        setState(() {
          debugPrint("onPanUpdate ${animation.value}");
          isDraggng=true;
          dragPosition = Offset(dragUpdateDetails.localPosition.dx,
              dragUpdateDetails.localPosition.dy);
        });
      },
      onPanEnd: (dragEndDetails) {
        setState(() {
          debugPrint("onPanEnd ${animation.value}");
          isDraggng=false;
          animationBeginValue=dragPosition.dy;
          animationEndValue = widget.widgetHeight / 2;
          initAnimation();
          _controller.reset();
          _controller.forward();
        //  dragPosition = Offset(widget.widgetWidth / 2, widget.widgetHeight / 2);
        });
      },
      child: Container(
        width: widget.widgetWidth,
        height: widget.widgetHeight,
        child: CustomPaint(
          painter: SliderPainter(dragPosition: isDraggng?dragPosition:Offset(dragPosition.dx,animation.value)),
        ),
      ),
    );
  }
}

class SliderPainter extends CustomPainter {
  final Offset dragPosition;
  Paint sliderPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeCap=StrokeCap.round
    ..strokeWidth = 8
    ..color = Colors.blue;

  SliderPainter({required this.dragPosition});

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    path.moveTo(0, size.height / 2);
    path.quadraticBezierTo(
        dragPosition.dx, dragPosition.dy, size.width, size.height / 2);
    canvas.drawPath(path, sliderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
