import 'dart:async';

import 'package:flutter/material.dart';
import 'package:indian_zaika/screens/home_screen.dart';
import 'package:indian_zaika/screens/onboarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splasn-screen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    Timer(
      const Duration(seconds: 2),
      () {
        if (_auth.currentUser != null) {
          Navigator.pushReplacementNamed(context, HomeScreen.id);
        } else {
          Navigator.pushReplacementNamed(context, OnboardingScreen.id);
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFF272C2F),
      body: Center(
        child: Image.asset(
          'images/IndianZaikaLogo.png',
          width: screenWidth / 3,
          height: screenWidth / 3,
        ),
      ),
    );
  }
}
