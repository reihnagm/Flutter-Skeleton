import 'dart:async';
import 'package:flutter/material.dart';

import '../../constants/color_palette.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    Duration _duration = Duration(seconds: 2);
    return Timer(_duration, () {
      Navigator.of(context).pushReplacementNamed('/MyApp');
    });
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.bgSplashScreen,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/splashscreen.png"),
          ),
        ),
      ),
    );
  }
}
