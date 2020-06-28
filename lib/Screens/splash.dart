import 'dart:io';
import 'dart:typed_data';

import 'package:animate_do/animate_do.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:gradient_text/gradient_text.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  FlutterTts _flutterTts = FlutterTts();
  static AudioCache player = AudioCache();
  double _top;
  Offset _tapDetails = Offset(0, 0);
  AnimationController _circlecontroller,
      _arc1Controller,
      _arc2Controller,
      _outerRectangleController;

  Animation<double> _circleanimation,
      _arc1Animation,
      _arc2Animation,
      _outerRectangleAnimation;

  double _circleFraction = 0.0,
      _arc1Fraction = 0.0,
      _arc2Fraction = 0.0,
      _outerRectangleFraction = 0.0;

  _initializeTTS() async {
    _flutterTts
      ..setPitch(0.5)
      ..speak('Hello agent 99');
  }

  @override
  void initState() {
    _circlecontroller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);

    _circleanimation = Tween(begin: 0.0, end: 100.0).animate(_circlecontroller)
      ..addListener(() {
        setState(() => _circleFraction = _circleanimation.value);
        if (_circleanimation.isCompleted) {
          _arc1Controller.forward();
        }
      });

    _arc1Controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    _arc1Animation = Tween(begin: 0.0, end: 100.0).animate(_arc1Controller)
      ..addListener(() {
        setState(() => _arc1Fraction = _arc1Animation.value);
        if (_arc1Animation.isCompleted) {
          _arc2Controller.forward();
        }
      });

    _arc2Controller = AnimationController(
        duration: Duration(seconds: 1),
        vsync: this,
        reverseDuration: Duration(seconds: 2));

    _arc2Animation = Tween(begin: 0.0, end: 100.0).animate(_arc2Controller)
      ..addListener(() {
        setState(() => _arc2Fraction = _arc2Animation.value);
        if (_arc2Animation.isCompleted) {
          _outerRectangleController.forward();
        }
      });

    _outerRectangleController =
        AnimationController(duration: Duration(milliseconds: 600), vsync: this);

    _outerRectangleAnimation =
        Tween(begin: 0.0, end: 100.0).animate(_outerRectangleController)
          ..addListener(() {
            setState(
                () => _outerRectangleFraction = _outerRectangleAnimation.value);
          });

    _circlecontroller.forward();

    Future.delayed(Duration(seconds: 4), () {
      _initializeTTS();
      _top -= 100;
    });

    player.load('audio/buttonPress.mp3');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _top = MediaQuery.of(context).size.height / 2;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (d) {
        setState(() {
          _tapDetails = d.globalPosition;
        });
      },
      child: Scaffold(
        body: Stack(
          children: [
            AnimatedPositioned(
              top: _top,
              duration: Duration(seconds: 2),
              left: MediaQuery.of(context).size.width / 2,
              child: Center(
                child: CustomPaint(
                  painter: OuterRectangleSplash(
                      outerRectangleAnimation: _outerRectangleFraction,
                      gesturePosition: _tapDetails),
                  child: RotationTransition(
                    turns: _circleanimation,
                    child: CustomPaint(
                      painter: CircluarSplash(animationValue: _circleFraction),
                      child: RotationTransition(
                        turns: _arc1Animation,
                        child: CustomPaint(
                          painter: ArcSplash1(arcAnimationValue: _arc1Fraction),
                          child: RotationTransition(
                            turns: _arc2Animation,
                            child: CustomPaint(
                              painter:
                                  ArcSplash2(arcAnimationValue: _arc2Fraction),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width / 2 - 70,
              bottom: MediaQuery.of(context).size.height / 2 - 100,
              child: FlatButton(
                onPressed: () async {
                  var filePath = "audio/buttonPress.mp3";
                  await player.play(filePath);
                },
                hoverColor: Colors.green,
                child: ZoomIn(
                  delay: Duration(seconds: 5),
                  child: GradientText(
                    'Play!',
                    gradient: LinearGradient(colors: [
                      Colors.deepPurple,
                      Colors.deepOrange,
                      Colors.pink
                    ]),
                    style: TextStyle(fontSize: 60, fontFamily: 'blanka'),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<File> writeToFile(ByteData data, String path) {
    final buffer = data.buffer;
    return File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
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
  final arcAnimationValue;
  ArcSplash1({this.arcAnimationValue}) {
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
        math.pi * 2 * arcAnimationValue / 100,
        false,
        _arcPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class ArcSplash2 extends CustomPainter {
  var _arcPaint;
  final arcAnimationValue;
  ArcSplash2({this.arcAnimationValue}) {
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
        math.pi * 2 * arcAnimationValue / 100,
        false,
        _arcPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class OuterRectangleSplash extends CustomPainter {
  var _rectanglePaint;
  final outerRectangleAnimation;
  final gesturePosition;
  OuterRectangleSplash({this.outerRectangleAnimation, this.gesturePosition}) {
    print(gesturePosition);
    _rectanglePaint = Paint()
      ..color = Color(0xff0891AB)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
  }
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(
        Offset(0, 0),
        Offset(gesturePosition.dx - 150, gesturePosition.dy - 150),
        _rectanglePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
