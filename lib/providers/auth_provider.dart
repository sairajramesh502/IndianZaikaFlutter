// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthenticationHelper with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String err = '';

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
      return e.message;
    }
  }

  //SIGN IN METHOD
  Future signIn({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
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
}
