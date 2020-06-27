import 'package:flutter/material.dart';
import 'package:retroplayer/Screens/splash.dart';
import 'package:retroplayer/Themes/app_theme.dart';

void main() {
  runApp(RetroPlayerApp());
}

class RetroPlayerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RetroPlayer',
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
