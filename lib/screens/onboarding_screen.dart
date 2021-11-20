// ignore_for_file: avoid_print, prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:indian_zaika/screens/login_screen.dart';
import 'package:indian_zaika/widgets/button.dart';

class OnboardingScreen extends StatefulWidget {
  static const String id = 'onboarding-screen';
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

final _controller = PageController(
  initialPage: 0,
);

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    List<Widget> _pages = [
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            'images/Onboard1.png',
            fit: BoxFit.cover,
            height: screenHeight / 1.4,
            width: screenWidth,
          ),
        ],
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            'images/Onboard2.png',
            fit: BoxFit.cover,
            height: screenHeight / 1.4,
            width: screenWidth,
          ),
        ],
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            'images/Onboard3.png',
            fit: BoxFit.cover,
            height: screenHeight / 1.4,
            width: screenWidth,
          ),
        ],
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF272C2F),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          //onboard Image Slider
          SizedBox(
            width: screenWidth,
            height: screenHeight / 1.01,
            child: PageView(
              controller: _controller,
              children: _pages,
            ),
          ),

          //Overall Bottom Container
          Positioned(
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(44),
                  topRight: Radius.circular(44),
                ),
                color: Color(0xFF272C2F),
              ),
              height: MediaQuery.of(context).size.width / 1.2,
              width: screenWidth,
              child: Padding(
                padding: const EdgeInsets.only(left: 30, top: 50, right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Text 1

                    const Text(
                      'Order & Let’s eat',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),

                    //space
                    const SizedBox(
                      height: 10,
                    ),

                    //Text 2

                    RichText(
                      text: const TextSpan(
                        text: 'Tasty',
                        style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w800,
                            color: Colors.white),
                        children: <TextSpan>[
                          TextSpan(
                            text: ' Food.',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFFFFC013),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //space
                    const SizedBox(
                      height: 20,
                    ),

                    //Text 3
                    const Text(
                      'Order Food and get Delivery in the Fastest\nTime in the Town',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        letterSpacing: 1.1,
                      ),
                    ),

                    //space
                    const SizedBox(
                      height: 50,
                    ),

                    //Button

                    ButtonGlobal(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, LoginScreen.id);
                        },
                        buttonText: 'Get Started'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
