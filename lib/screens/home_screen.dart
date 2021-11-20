import 'package:flutter/material.dart';
import 'package:indian_zaika/constants/constants.dart';
import 'package:indian_zaika/providers/auth_provider.dart';
import 'package:indian_zaika/screens/onboarding_screen.dart';
import 'package:provider/provider.dart';

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

    //Scaffold Message

    void scaffoldMessage(String message) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: kAccentColor,
        content: Text(message, style: const TextStyle(color: kPrimaryColor)),
      ));
    }

    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: TextButton(
          onPressed: () {
            _authProv.signOut().then((result) {
              if (result == null) {
                Navigator.pushReplacementNamed(context, OnboardingScreen.id);
              } else {
                scaffoldMessage(result);
              }
            });
          },
          child: const Text(
            'Home Screen',
            style: kHintText,
          ),
        ),
      ),
    );
  }
}
