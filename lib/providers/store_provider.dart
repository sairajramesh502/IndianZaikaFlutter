import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:indian_zaika/screens/onboarding_screen.dart';
import 'package:indian_zaika/services/shop_service.dart';
import 'package:indian_zaika/services/user_services.dart';

class StoreProvider with ChangeNotifier {
  StoreServices _storeServices = StoreServices();
  userServices _userServices = userServices();
  User? user = FirebaseAuth.instance.currentUser;
  String? userEmail = FirebaseAuth.instance.currentUser!.email;
  var userLat = 0.0;
  var userLng = 0.0;

  Future<void> getUserLocationData(context) async {
    _userServices.getUserByEmial(userEmail!).then((result) {
      if (user != null) {
        userLat = (result.data() as dynamic)['latitude'];
        userLng = (result.data() as dynamic)['longitude'];
      } else {
        Navigator.pushReplacementNamed(context, OnboardingScreen.id);
      }
    });
  }
}
