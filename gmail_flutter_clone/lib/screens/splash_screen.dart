import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:gmail_flutter_clone/screens/home_screen.dart';
import 'package:gmail_flutter_clone/screens/signin_screen.dart';
import 'package:gmail_flutter_clone/screens/signup_screen.dart';

import 'package:loading_indicator/loading_indicator.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splash-screen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Timer(Duration(seconds: 5), () {
      FirebaseAuth.instance.authStateChanges().listen((User user) {
        if (user == null) {
          Navigator.pushReplacementNamed(context, SignInScreen.id);
        } else {
          Navigator.pushReplacementNamed(context, HomeScreen.id);
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            SizedBox(
                height: 180,
                width: 180,
                child: Image.asset('assets/images/logo1.png')),
            SizedBox(
              height: 10,
            ),
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'Say Hello To world!',
                  textStyle: const TextStyle(
                    fontSize: 20.0,
                    color: Color(0XFFC5221f),
                    fontWeight: FontWeight.bold,
                  ),
                  speed: const Duration(milliseconds: 150),
                ),
              ],
              totalRepeatCount: 1,
              pause: const Duration(milliseconds: 700),
              displayFullTextOnTap: true,
              stopPauseOnTap: true,
            ),
            Spacer(),
            SizedBox(
              height: 100,
              width: 100,
              child: LoadingIndicator(
                indicatorType: Indicator.ballClipRotatePulse,

                /// Required, The loading type of the widget
                colors: const [
                  Colors.blue,
                  Colors.black,
                ],

                /// Optional, The color collections
                /// Optional, the stroke backgroundColor
              ),
            )
          ],
        ),
      ),
    );
  }
}
