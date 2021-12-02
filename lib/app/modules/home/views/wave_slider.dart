
import 'package:flutter/material.dart';
import 'package:flutter_baseapp/app/modules/home/views/wave_painter.dart';
class WaveSlider extends StatefulWidget {
  final double width, height;

  const WaveSlider({required this.width, required this.height});

  @override
  _WaveSliderState createState() => _WaveSliderState();
}
class _WaveSliderState extends State<WaveSlider> {
  var dragPercentage = 0.0;
  var dragPosition = 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        child: Container(
          width: widget.width,
          height: widget.height,
          color: Colors.red,
          child: CustomPaint(
            painter: WavePainter(sliderPosition: dragPosition),
          ),
        ),
        onHorizontalDragUpdate: (dragDetails) =>
        {handleHorizontalDrag(context, dragDetails)},
      ),
    );
  }

  handleHorizontalDrag(BuildContext context, DragUpdateDetails dragDetails) {
    RenderBox box = context.findRenderObject() as RenderBox;
    var localPos = box.globalToLocal(dragDetails.globalPosition);
   // debugPrint(localPos.dx.toString());

    if (localPos.dx <= 0) {
      dragPercentage = 0;
      dragPosition = 0.0;
    } else if (localPos.dx > widget.width) {
      dragPercentage = 100;
      dragPosition = widget.width;
    } else {
      dragPosition = localPos.dx;
      dragPercentage = localPos.dx / widget.width * 100.0;
    }
    setState(() {});
  }
}