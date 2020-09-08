import 'package:flutter/material.dart';
import 'package:flutter_splash/flutter_splash.dart';
import 'package:music_player/app/modules/home/home_page.dart';

// Splash screen displayed at startup

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return new Splash(
        seconds: 5,
        navigateAfterSeconds: new HomePage(),
        title: new Text(
          'Music Player',
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        image: new Image.asset('assets/images/splash_screen_image.png'),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        onClick: () => print("Flutter Egypt"),
        loaderColor: Colors.red);
  }
}
