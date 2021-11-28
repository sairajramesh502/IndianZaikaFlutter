// ignore_for_file: non_constant_identifier_names

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:indian_zaika/constants/constants.dart';
import 'package:indian_zaika/providers/auth_provider.dart';
import 'package:indian_zaika/screens/login_screen.dart';
import 'package:indian_zaika/widgets/button.dart';
import 'package:animate_do/animate_do.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatefulWidget {
  static const String id = 'forgotPassword-screen';
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _EmailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //Scaffold Message

    void scaffoldMessage(String message) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: kAccentColor,
        content: Text(message, style: const TextStyle(color: kPrimaryColor)),
      ));
    }

    final _forgotPasswordProvider = Provider.of<AuthenticationHelper>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFF272C2F),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          //onboard Image Slider
          SizedBox(
            width: screenWidth,
            height: screenHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'images/ForgotPasswordImg.png',
                  fit: BoxFit.cover,
                  height: screenHeight / 1.5,
                  width: screenWidth,
                ),
              ],
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
                padding: const EdgeInsets.only(left: 35, top: 30, right: 35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Text 1

                    FadeInUp(
                      duration: const Duration(milliseconds: 500),
                      child: const Text(
                        'Forgot Password',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    //space
                    const SizedBox(
                      height: 16,
                    ),

                    //Text 2
                    FadeInUp(
                      duration: const Duration(milliseconds: 550),
                      child: const Text(
                        'Forgot your Password No Wories we have got you\nenter your valid email below',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                    ),

                    //space
                    const SizedBox(
                      height: 16,
                    ),

                    //Text Input
                    FadeInUp(
                      duration: const Duration(milliseconds: 600),
                      child: Form(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //Emial
                            const Text('E-mail', style: kLabelStyle),
                            //Space
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _EmailController,
                              style: kHintText,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: 'Enter Your Email',
                                hintStyle: kHintText,
                                filled: true,
                                fillColor: kCardBackColor,
                                contentPadding: const EdgeInsets.all(22.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    //Space
                    const SizedBox(
                      height: 22,
                    ),

                    //Button

                    FadeInUp(
                      duration: const Duration(milliseconds: 650),
                      child: ButtonGlobal(
                          onPressed: () {
                            if (_EmailController.text == '') {
                              scaffoldMessage(
                                  'You Might have missed an Important Detail. Please enter all the required Details');
                            } else if (EmailValidator.validate(
                                    _EmailController.text) ==
                                false) {
                              scaffoldMessage(
                                  'Oh No! The Email is badly Formatted Enter a Valid Email');
                            } else {
                              _forgotPasswordProvider
                                  .resetPassword(email: _EmailController.text)
                                  .then((result) {
                                if (result == null) {
                                  scaffoldMessage(
                                      'We have sent you a Email in your Entered Email id to reset your Password. Kindly Check.');
                                  Navigator.pushReplacementNamed(
                                      context, LoginScreen.id);
                                } else {
                                  scaffoldMessage(result);
                                }
                              });
                            }
                          },
                          buttonText: 'Reset Password'),
                    ),
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
