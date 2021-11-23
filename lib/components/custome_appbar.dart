import 'package:flutter/material.dart';
import 'package:indian_zaika/constants/constants.dart';

class CustomeAppBar extends StatefulWidget {
  const CustomeAppBar({Key? key}) : super(key: key);

  @override
  _CustomeAppBarState createState() => _CustomeAppBarState();
}

class _CustomeAppBarState extends State<CustomeAppBar> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      flexibleSpace: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {},
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
                    children: const [
                      Text(
                        '8',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: kAccentColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w900),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        'Addressjjjjjjjjjjjjjjjjjjjjjjjjjjjjhhhhhhhhhhhhhhhhhhhhh',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
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
