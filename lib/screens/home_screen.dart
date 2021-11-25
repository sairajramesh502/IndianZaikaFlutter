// ignore_for_file: unused_import, unused_local_variable, unused_element

import 'package:flutter/material.dart';
import 'package:indian_zaika/components/custome_appbar.dart';
import 'package:indian_zaika/components/image_slider.dart';
import 'package:indian_zaika/constants/constants.dart';
import 'package:indian_zaika/providers/auth_provider.dart';
import 'package:indian_zaika/screens/map_screen.dart';
import 'package:indian_zaika/screens/onboarding_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home-screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final _authProv = Provider.of<AuthenticationHelper>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    //Scaffold Message

    void scaffoldMessage(String message) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: kAccentColor,
        content: Text(message, style: const TextStyle(color: kPrimaryColor)),
      ));
    }

    return Scaffold(
      backgroundColor: kPrimaryColor,
      //AppBar
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenWidth / 3),
        child: const CustomeAppBar(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Text 1
              const Text(
                "Let's Eat",
                style: kTextStyleHead2,
              ),

              //Space
              const SizedBox(
                height: 10,
              ),

              //Text 2
              RichText(
                text: const TextSpan(
                  text: 'Quality',
                  style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w800,
                      color: Colors.white),
                  children: <TextSpan>[
                    TextSpan(
                      text: ' Food',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFFFFC013),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: screenWidth / 13,
              ),

              //Search Bar and Button
              Row(
                children: [
                  Flexible(
                    child: TextField(
                      style: kHintText,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.search,
                          color: kPrimaryColor,
                        ),
                        hintText: 'Search Food...',
                        hintStyle: const TextStyle(
                          fontSize: 13,
                          color: kCardBackColor,
                          fontWeight: FontWeight.w400,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.all(25.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    height: screenWidth / 6,
                    width: screenWidth / 6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: kAccentColor,
                    ),
                    child: Center(
                      child: Image.asset('images/filter.png',
                          width: 30, height: 30),
                    ),
                  ),
                ],
              ),

              //Image Slider
              const BannerSlider(),

              TextButton(
                onPressed: () {
                  _authProv.signOut().then((result) {
                    if (result == null) {
                      Navigator.pushReplacementNamed(
                          context, OnboardingScreen.id);
                    } else {
                      scaffoldMessage(result);
                    }
                  });
                },
                child: const Text('Log Out', style: kHintText),
              )
            ],
          ),
        ),
      ),
    );
  }
}
