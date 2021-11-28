// ignore_for_file: unnecessary_string_interpolations

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:indian_zaika/constants/constants.dart';
import 'package:indian_zaika/providers/store_provider.dart';
import 'package:indian_zaika/screens/onboarding_screen.dart';
import 'package:indian_zaika/services/shop_service.dart';
import 'package:indian_zaika/services/user_services.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class TopPickedRest extends StatefulWidget {
  const TopPickedRest({Key? key}) : super(key: key);

  @override
  _TopPickedRestState createState() => _TopPickedRestState();
}

class _TopPickedRestState extends State<TopPickedRest> {
  StoreServices _storeServices = StoreServices();
  userServices _userServices = userServices();
  User? user = FirebaseAuth.instance.currentUser;
  String? userEmail = FirebaseAuth.instance.currentUser!.email;
  var userLat = 0.0;
  var userLng = 0.0;

  @override
  void initState() {
    super.initState();
    _userServices.getUserByEmial(userEmail!).then((result) {
      if (user != null) {
        if (mounted) {
          setState(() {
            userLat = (result.data() as dynamic)['latitude'];
            userLng = (result.data() as dynamic)['longitude'];
          });
        }
      } else {
        Navigator.pushReplacementNamed(context, OnboardingScreen.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final _StoreData = Provider.of<StoreProvider>(context);

    String getDistance(location) {
      var distance = Geolocator.distanceBetween(
          userLat, userLng, location.latitude, location.longitude);
      var distanceInKm = distance / 1000;
      return distanceInKm.toStringAsFixed(2);
    }

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      child: StreamBuilder(
        stream: _storeServices.getTopPickedRestaurant(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Column(
              children: [
                Flexible(
                  child: Shimmer.fromColors(
                    baseColor: kCardBackColor,
                    highlightColor: kShimmerHighlight,
                    child: ListView(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: [
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: screenWidth / 2.5,
                          height: screenWidth / 1.61,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: kCardBackColor,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: screenWidth / 2.5,
                          height: screenWidth / 1.61,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: kCardBackColor,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: screenWidth / 2.5,
                          height: screenWidth / 1.61,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: kCardBackColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }

          List shopDistance = [];
          for (int i = 0; i <= snapshot.data.docs.length - 1; i++) {
            var distance = Geolocator.distanceBetween(
                userLat,
                userLng,
                snapshot.data.docs[i]['location'].latitude,
                snapshot.data.docs[i]['location'].longitude);
            var distanceInKm = distance / 1000;
            shopDistance.add(distanceInKm);
          }
          shopDistance.sort();
          if (shopDistance[0] > 10) {
            return Container();
          }
          return Column(
            children: [
              Flexible(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: snapshot.data.docs
                      .map<Widget>((DocumentSnapshot document) {
                    if (double.parse(getDistance(document['location'])) <= 10) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: kCardBackColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    document['imageUrl'],
                                    fit: BoxFit.cover,
                                    width: screenWidth / 3,
                                    height: screenWidth / 2.8,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  document['restaurantName'],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: kCardTextHead,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text:
                                            '⭐ ${document['rating'].toString()}',
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: kAccentColor),
                                        children: <TextSpan>[
                                          const TextSpan(
                                            text: ' . ',
                                            style: TextStyle(
                                              fontSize: 36,
                                              fontWeight: FontWeight.w800,
                                              color: Color(0xFFFFC013),
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                '${getDistance(document['location'])} KM',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w800,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }).toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
