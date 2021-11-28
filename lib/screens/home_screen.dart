// ignore_for_file: unused_import, unused_local_variable, unused_element

import 'package:flutter/material.dart';
import 'package:indian_zaika/components/custome_appbar.dart';
import 'package:indian_zaika/components/image_slider.dart';
import 'package:indian_zaika/components/nearby_restaurants.dart';
import 'package:indian_zaika/components/top_picks.dart';
import 'package:indian_zaika/constants/constants.dart';
import 'package:indian_zaika/providers/auth_provider.dart';
import 'package:indian_zaika/screens/map_screen.dart';
import 'package:indian_zaika/screens/onboarding_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
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

      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: CustomeAppBar())
          ];
        },
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            children: [
              Column(
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
                      InkWell(
                        onTap: () {
                          pushNewScreenWithRouteSettings(
                            context,
                            settings: RouteSettings(name: MapScreen.id),
                            screen: MapScreen(),
                            withNavBar: false,
                            pageTransitionAnimation:
                                PageTransitionAnimation.cupertino,
                          );
                        },
                        child: Container(
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
                      ),
                    ],
                  ),

                  //Image Slider
                  const BannerSlider(),

                  //Space
                  SizedBox(
                    height: screenWidth / 13,
                  ),

                  //Top Picked Restaurants

                  //Label1
                  RichText(
                    text: const TextSpan(
                      text: 'Top Picked',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Colors.white),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' Restaurants',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFFFFC013),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //Space
                  SizedBox(
                    height: screenWidth / 20,
                  ),

                  SizedBox(
                    height: screenWidth / 1.61,
                    child: const TopPickedRest(),
                  ),

                  //All Near By Restaurants

                  //Space
                  SizedBox(
                    height: screenWidth / 13,
                  ),

                  //Label1
                  RichText(
                    text: const TextSpan(
                      text: 'All Nearby',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Colors.white),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' Restaurants',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFFFFC013),
                          ),
                        ),
                      ],
                    ),
                  ),
                  NearByRestaurants(),
                  SizedBox(
                    height: screenWidth / 10,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
