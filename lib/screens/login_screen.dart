// ignore_for_file: import_of_legacy_library_into_null_safe, non_constant_identifier_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:indian_zaika/constants/constants.dart';
import 'package:indian_zaika/providers/auth_provider.dart';
import 'package:indian_zaika/screens/forgot_password.dart';
import 'package:indian_zaika/screens/register_screen.dart';
import 'package:indian_zaika/screens/select_location.dart';
import 'package:indian_zaika/widgets/already_button.dart';
import 'package:indian_zaika/widgets/button.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login-screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _EmailController = TextEditingController();
  final _PasswordController = TextEditingController();
  bool _isVisible = false;
  @override
  Widget build(BuildContext context) {
    final _loginAuth = Provider.of<AuthenticationHelper>(context);

    //Scaffold Message

    void scaffoldMessage(String message) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: kAccentColor,
        content: Text(message, style: TextStyle(color: kPrimaryColor)),
      ));
    }

    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Image Logo
            Image.asset(
              'images/IndianZaikaLogo.png',
              width: screenWidth / 3.8,
              height: screenWidth / 3.8,
            ),

            //Space
            SizedBox(height: screenWidth / 8),

            //Text 1
            const Text(
              'Sign In With',
              style: kTextStyleHead1,
            ),

            //Space
            SizedBox(height: screenWidth / 8),

            //Alternet Sign In

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: screenWidth / 2.5,
                  height: screenWidth / 6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: kActionbuttonBack,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'images/facebookIcon.png',
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        const Text(
                          'FACEBOOK',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  width: screenWidth / 2.5,
                  height: screenWidth / 6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: kActionbuttonBack,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'images/googleIcon.png',
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        const Text(
                          'GOOGLE',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              letterSpacing: 1.1),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),

            //Space
            SizedBox(height: screenWidth / 8),

            //Or

            RichText(
              text: const TextSpan(
                text: '--------------------',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w100,
                    color: Colors.white),
                children: <TextSpan>[
                  TextSpan(
                    text: ' Or ',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  TextSpan(
                    text: '--------------------',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w100,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            //Space
            SizedBox(height: screenWidth / 8),

            //Text Inputs Email and Password

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Emial
                    const Text('E-mail', style: kLabelStyle),
                    //Space
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _EmailController,
                      style: kHintText,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Enter Your Email',
                        hintStyle: kHintText,
                        filled: true,
                        fillColor: kCardBackColor,
                        contentPadding: EdgeInsets.all(22.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    //Space
                    SizedBox(height: screenWidth / 20),

                    //Password
                    const Text('Password', style: kLabelStyle),
                    //Space
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _PasswordController,
                      style: kHintText,
                      obscureText: _isVisible ? false : true,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: IconButton(
                            color: Color(0xFFD4CDCD),
                            splashRadius: 0.1,
                            icon: _isVisible
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _isVisible = !_isVisible;
                              });
                            },
                          ),
                        ),
                        hintText: 'Enter Your Password',
                        hintStyle: kHintText,
                        filled: true,
                        fillColor: kCardBackColor,
                        contentPadding: EdgeInsets.all(22.0),
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

            //Forgot Password

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, ForgotPassword.id);
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: kHintText,
                    ),
                  ),
                ],
              ),
            ),

            //Space
            SizedBox(height: 10),

            //Login Button
            _loginAuth.isAuthLoading
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: Shimmer.fromColors(
                      baseColor: kAccentColor,
                      highlightColor: kShimmerHighlightBtn,
                      child: Container(
                        width: screenWidth,
                        height: screenWidth / 7,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: kAccentColor,
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: ButtonGlobal(
                        onPressed: () {
                          setState(() {
                            _loginAuth.isAuthLoading = true;
                          });
                          if (_EmailController.text == '' ||
                              _PasswordController.text == '') {
                            scaffoldMessage(
                                'You Might have missed an Important Detail. Please enter all the required Details');
                          } else if (EmailValidator.validate(
                                  _EmailController.text) ==
                              false) {
                            scaffoldMessage(
                                'Oh No! The Email is badly Formatted Enter a Valid Email');
                          } else if (_PasswordController.text.length < 7) {
                            scaffoldMessage(
                                'Oh No! That might be a Weak Password kindly Enter a Password with Altleast 7 characters');
                          } else {
                            _loginAuth
                                .signIn(
                                    email: _EmailController.text,
                                    password: _PasswordController.text)
                                .then((result) {
                              if (result == null) {
                                Navigator.pushReplacementNamed(
                                    context, SelectLocation.id);
                                setState(() {
                                  _loginAuth.isAuthLoading = false;
                                });
                              } else {
                                scaffoldMessage(result);
                                setState(() {
                                  _loginAuth.isAuthLoading = false;
                                });
                              }
                            });
                          }
                        },
                        buttonText: 'Login'),
                  ),

            //Space
            SizedBox(height: screenWidth / 20),

            //Already Button
            AlreadyButton(
                onPressed: () {
                  Navigator.pushNamed(context, RegisterScreen.id);
                },
                firstText: 'Dont have an account ? ',
                secondText: 'Register Now'),
          ],
        ),
      ),
    );
  }
}
