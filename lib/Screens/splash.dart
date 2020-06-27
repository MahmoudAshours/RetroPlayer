import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  double _fraction = 0.0;

  @override
  void initState() {
    _controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);

    _animation = Tween(begin: 0.0, end: 100.0).animate(_controller)
      ..addListener(() => setState(() => _fraction = _animation.value));

    _controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomPaint(
          painter: CircluarSplash(animationValue: _fraction),
        ),
      ),
    );
  }
}

class CircluarSplash extends CustomPainter {
  /// The animation value to draw the outer cirle of splash.
  final double animationValue;
  var _circlePaint;

  CircluarSplash({this.animationValue}) {
    _circlePaint = Paint()
      ..color = Color(0xffDEFEFF)
      ..strokeWidth = 3.2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawArc(
        Rect.fromCircle(
          center: Offset(0, 0),
          radius: 100,
        ),
        -math.pi / 2,
        math.pi * 2 * animationValue / 100,
        false,
        _circlePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class ArcSplash extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {}

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
