// ignore_for_file: unnecessary_this, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthenticationHelper with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String err = '';
  bool isAuthLoading = false;

  //SIGN UP METHOD
  Future signUp(
      {required String email,
      required String password,
      required String mobile,
      required String firstname,
      required String lastname,
      required String fullname}) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((credentials) {
        firestore.collection('Users').doc(email).set({
          'email': email,
          'mobile': mobile,
          'firstname': firstname,
          'lastname': lastname,
          'fullname': fullname,
        });
      });
      return null;
    } on FirebaseAuthException catch (e) {
      this.isAuthLoading = false;
      return e.message;
    }
  }

  //SIGN IN METHOD
  Future signIn({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      this.isAuthLoading = false;
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN OUT METHOD
  Future signOut() async {
    await _auth.signOut();

    print('signout');
  }

  //Update User
  Future updateUserLocation(
      {required double longitude,
      required double latitude,
      required String address}) async {
    await firestore.collection('Users').doc(_auth.currentUser!.email).update({
      'location': GeoPoint(latitude, longitude),
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
    });
    return null;
  }
}
