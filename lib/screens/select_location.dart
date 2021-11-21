// ignore_for_file: unused_field, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:indian_zaika/constants/constants.dart';
import 'package:indian_zaika/providers/location_provider.dart';
import 'package:indian_zaika/screens/map_screen.dart';
import 'package:indian_zaika/widgets/button.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class SelectLocation extends StatefulWidget {
  static const String id = 'selectlocation-screen';
  const SelectLocation({Key? key}) : super(key: key);

  @override
  _SelectLocationState createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
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

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    final _selLocProvider =
        Provider.of<LocationProvider>(context, listen: false);

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
                  'images/SelectLocationImg.png',
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
                padding: const EdgeInsets.only(left: 35, top: 60, right: 35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //Text 1

                    const Text(
                      'Select Location',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),

                    //space
                    const SizedBox(height: 16),

                    //Text 2
                    const Text(
                      'Select the Location you need your\nfood to be delivered.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),

                    //space
                    const SizedBox(
                      height: 16,
                    ),

                    //Space
                    SizedBox(
                      height: screenWidth / 5,
                    ),

                    //Button

                    _selLocProvider.loading
                        ? Shimmer.fromColors(
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
                          )
                        : ButtonGlobal(
                            onPressed: () async {
                              setState(() {
                                _selLocProvider.loading = true;
                              });
                              await _selLocProvider.getCurrentPosition();
                              if (_selLocProvider.permisionAllowed) {
                                Navigator.pushReplacementNamed(
                                    context, MapScreen.id);
                                setState(() {
                                  _selLocProvider.loading = false;
                                });
                              } else {
                                scaffoldMessage(
                                    'Location Permission Not allowed. Kindly Allow Location Permissions');
                                setState(() {
                                  _selLocProvider.loading = false;
                                });
                              }
                            },
                            buttonText: 'Set Location'),
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
