import 'package:drawing_animation/drawing_animation.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController _circlecontroller;
  Animation<double> _circleanimation;
  double _circleFraction = 0.0;

  @override
  void initState() {
    _circlecontroller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);

    _circleanimation = Tween(begin: 0.0, end: 100.0).animate(_circlecontroller)
      ..addListener(
          () => setState(() => _circleFraction = _circleanimation.value));

    _circlecontroller.forward();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedDrawing.svg(
            "assets/images/BlueTech.svg",
            run: true,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            duration: new Duration(seconds: 10),
            animationCurve: Curves.decelerate,
            scaleToViewport: true,
            lineAnimation: LineAnimation.oneByOne,
          ),
          Center(
            child: CustomPaint(
              painter: OuterRectangleSplash(),
              child: CustomPaint(
                painter: RectangleSplash(),
                child: CustomPaint(
                  painter: CircluarSplash(animationValue: _circleFraction),
                  child: CustomPaint(
                    painter: ArcSplash1(),
                    child: CustomPaint(painter: ArcSplash2()),
                  ),
                ),
              ),
            ),
          ),
        ],
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
      ..strokeWidth = 1.2
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

class ArcSplash1 extends CustomPainter {
  var _arcPaint;
  ArcSplash1() {
    _arcPaint = Paint()
      ..color = Color(0xfff887ff)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
  }
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawArc(
        Rect.fromCircle(
          center: Offset(0, 0),
          radius: 50,
        ),
        -math.pi / 2,
        math.pi * 2,
        false,
        _arcPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class ArcSplash2 extends CustomPainter {
  var _arcPaint;
  ArcSplash2() {
    _arcPaint = Paint()
      ..color = Color(0xffde004e)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
  }
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawArc(
        Rect.fromCircle(
          center: Offset(0, 0),
          radius: 60,
        ),
        -math.pi / 2,
        math.pi * 2,
        false,
        _arcPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class RectangleSplash extends CustomPainter {
  var _rectanglePaint;
  RectangleSplash() {
    _rectanglePaint = Paint()
      ..color = Color(0xff0891AB)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
  }
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
        Rect.fromCenter(center: Offset(0, 0), height: 150, width: 310),
        _rectanglePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class OuterRectangleSplash extends CustomPainter {
  var _rectanglePaint;
  OuterRectangleSplash() {
    _rectanglePaint = Paint()
      ..color = Color(0xff0891AB)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
  }
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
        Rect.fromCenter(center: Offset(0, 0), height: 190, width: 410),
        _rectanglePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
