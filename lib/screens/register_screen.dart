import 'package:flutter/material.dart';
import 'package:indian_zaika/constants/constants.dart';
import 'package:indian_zaika/screens/login_screen.dart';
import 'package:indian_zaika/widgets/already_button.dart';
import 'package:indian_zaika/widgets/button.dart';
import 'package:email_validator/email_validator.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = 'register-screen';
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _NameController = TextEditingController();
  final _EmailController = TextEditingController();
  final _MobileController = TextEditingController();
  final _PasswordController = TextEditingController();
  final _CPasswordController = TextEditingController();

  bool _isPVisible = false;
  bool _isCPVisible = false;

  @override
  Widget build(BuildContext context) {
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Space
            SizedBox(
              height: screenWidth / 8,
            ),
            //Heading Text
            const Text('Register Yourself', style: kTextStyleHead1),

            //Space
            SizedBox(
              height: screenWidth / 8,
            ),

            //Text Inputs

            //Text Inputs Email and Password

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Name
                    const Text('Full Name', style: kLabelStyle),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _NameController,
                      style: kHintText,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        hintText: 'Enter Your Full Name',
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

                    //Email
                    const Text('E-mail', style: kLabelStyle),
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

                    //Mobile
                    const Text('Mobile', style: kLabelStyle),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _MobileController,
                      style: kHintText,
                      maxLength: 10,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        counterText: '',
                        hintText: 'Enter Your Mobile',
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
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _PasswordController,
                      style: kHintText,
                      obscureText: _isPVisible ? false : true,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: IconButton(
                            color: Color(0xFFD4CDCD),
                            splashRadius: 0.1,
                            icon: _isPVisible
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _isPVisible = !_isPVisible;
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

                    //Space
                    SizedBox(height: screenWidth / 20),

                    //Confirm Password
                    const Text('Confirm Password', style: kLabelStyle),
                    //Space
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _CPasswordController,
                      style: kHintText,
                      obscureText: _isCPVisible ? false : true,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: IconButton(
                            color: Color(0xFFD4CDCD),
                            splashRadius: 0.1,
                            icon: _isCPVisible
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _isCPVisible = !_isCPVisible;
                              });
                            },
                          ),
                        ),
                        hintText: 'Confirm Your Password',
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

            //Space
            SizedBox(height: screenWidth / 8),

            //Login Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: ButtonGlobal(
                  onPressed: () {
                    if (_NameController.text == '' ||
                        _EmailController.text == '' ||
                        _MobileController.text == '' ||
                        _PasswordController.text == '' ||
                        _CPasswordController.text == '') {
                      scaffoldMessage(
                          'You Might have missed an Important Detail. Please enter all the required Details');
                    } else if (_MobileController.text.length < 10) {
                      scaffoldMessage(
                          'You Might have Misentered your Mobile Number. Please Check');
                    } else if (_PasswordController.text.length < 7) {
                      scaffoldMessage(
                          'Oh No! That might be a Weak Password kindly Enter a Password with Altleast 7 characters');
                    } else if (_PasswordController.text !=
                        _CPasswordController.text) {
                      scaffoldMessage('Oh No! The Passwords did not Match');
                    } else if (EmailValidator.validate(_EmailController.text) ==
                        false) {
                      scaffoldMessage(
                          'Oh No! The Email is badly Formatted Enter a Valid Email');
                    } else {
                      scaffoldMessage('Validation Done');
                    }
                  },
                  buttonText: 'Register'),
            ),

            //Space
            SizedBox(height: screenWidth / 20),

            //Already Button
            AlreadyButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, LoginScreen.id);
                },
                firstText: 'Already have an account ? ',
                secondText: 'Login Now'),
          ],
        ),
      ),
    );
  }
}
