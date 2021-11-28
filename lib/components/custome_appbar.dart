import 'package:flutter/material.dart';
import 'package:indian_zaika/constants/constants.dart';
import 'package:indian_zaika/providers/auth_provider.dart';
import 'package:indian_zaika/screens/map_screen.dart';
import 'package:indian_zaika/screens/onboarding_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomeAppBar extends StatefulWidget {
  const CustomeAppBar({Key? key}) : super(key: key);

  @override
  _CustomeAppBarState createState() => _CustomeAppBarState();
}

class _CustomeAppBarState extends State<CustomeAppBar> {
  String? _featureName = '';
  String? _address = '';
  @override
  void initState() {
    getPrefs();
    super.initState();
  }

  getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? featureName = prefs.getString('featureName');
    String? address = prefs.getString('address');
    setState(() {
      _featureName = featureName;
      _address = address;
    });
  }

  @override
  Widget build(BuildContext context) {
    //Scaffold Message

    void scaffoldMessage(String message) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: kAccentColor,
        content: Text(message, style: const TextStyle(color: kPrimaryColor)),
      ));
    }

    final _authProv = Provider.of<AuthenticationHelper>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    return SliverAppBar(
      snap: false,
      pinned: false,
      floating: false,
      expandedHeight: screenWidth / 2.5,
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      flexibleSpace: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                pushNewScreenWithRouteSettings(
                  context,
                  settings: RouteSettings(name: MapScreen.id),
                  screen: MapScreen(),
                  withNavBar: false,
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              },
              child: Container(
                height: screenWidth / 5,
                width: screenWidth / 2.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: kCardBackColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            _featureName!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: kAccentColor,
                                fontSize: screenWidth / 20,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                        const Flexible(
                          child: SizedBox(
                            height: 6,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            _address!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: screenWidth / 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                _authProv.signOut().then((result) {
                  if (result == null) {
                    pushNewScreenWithRouteSettings(
                      context,
                      settings: RouteSettings(name: OnboardingScreen.id),
                      screen: OnboardingScreen(),
                      withNavBar: false,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  } else {
                    scaffoldMessage(result);
                  }
                });
              },
              child: Image.asset(
                'images/LogoProfile.png',
                height: screenWidth / 5,
                width: screenWidth / 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
