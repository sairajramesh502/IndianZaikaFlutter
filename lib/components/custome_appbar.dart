import 'package:flutter/material.dart';
import 'package:indian_zaika/constants/constants.dart';
import 'package:indian_zaika/screens/map_screen.dart';
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
    double screenWidth = MediaQuery.of(context).size.width;
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      flexibleSpace: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, MapScreen.id);
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _featureName!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: kAccentColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        _address!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
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
