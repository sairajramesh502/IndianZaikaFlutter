import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:indian_zaika/constants/constants.dart';
import 'package:indian_zaika/providers/store_provider.dart';
import 'package:indian_zaika/screens/onboarding_screen.dart';
import 'package:indian_zaika/services/shop_service.dart';
import 'package:indian_zaika/services/user_services.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:provider/provider.dart';

class NearByRestaurants extends StatefulWidget {
  const NearByRestaurants({Key? key}) : super(key: key);

  @override
  _NearByRestaurantsState createState() => _NearByRestaurantsState();
}

class _NearByRestaurantsState extends State<NearByRestaurants> {
  StoreServices _storeServices = StoreServices();
  userServices _userServices = userServices();
  User? user = FirebaseAuth.instance.currentUser;
  String? userEmail = FirebaseAuth.instance.currentUser!.email;
  var userLat = 0.0;
  var userLng = 0.0;
  bool isFav = false;
  PaginateRefreshedChangeListener refreshedChangeListener =
      PaginateRefreshedChangeListener();

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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final _StoreData = Provider.of<StoreProvider>(context);

    String getDistance(location) {
      var distance = Geolocator.distanceBetween(
          userLat, userLng, location.latitude, location.longitude);
      var distanceInKm = distance / 1000;
      return distanceInKm.toStringAsFixed(2);
    }

    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: _storeServices.getTopPickedRestaurant(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          List shopDistance = [];
          for (int i = 0; i <= snapshot.data!.docs.length - 1; i++) {
            var distance = Geolocator.distanceBetween(
                userLat,
                userLng,
                snapshot.data!.docs[i]['location'].latitude,
                snapshot.data!.docs[i]['location'].longitude);
            var distanceInKm = distance / 1000;
            shopDistance.add(distanceInKm);
          }
          shopDistance.sort();
          if (shopDistance[0] > 10) {
            return Container();
          }
          return Padding(
            padding: EdgeInsets.all(2),
            child: Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RefreshIndicator(
                    child: PaginateFirestore(
                      itemBuilderType: PaginateBuilderType.listView,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, documentSnapshots, index) =>
                          Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Container(
                          width: screenWidth,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: kCardBackColor,
                          ),
                          child: Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15)),
                                    child: Image.network(
                                      (documentSnapshots[index].data()
                                          as dynamic)['imageUrl'],
                                      fit: BoxFit.cover,
                                      width: screenWidth,
                                      height: screenWidth / 2,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          (documentSnapshots[index].data()
                                              as dynamic)['restaurantName'],
                                          style: kCardTextHead2,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Colors.orange),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4.0, vertical: 2),
                                            child: Text(
                                              '${(documentSnapshots[index].data() as dynamic)['rating']} ★',
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 15.0, left: 15, bottom: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            (documentSnapshots[index].data()
                                                as dynamic)['dialog'],
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Text(
                                          '${getDistance((documentSnapshots[index].data() as dynamic)['location'])} KM',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Positioned(
                                right: 10,
                                top: 10,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      isFav = !isFav;
                                    });
                                  },
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.white70,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Center(
                                      child: isFav
                                          ? const Icon(
                                              Icons.favorite,
                                              size: 28,
                                              color: Colors.red,
                                            )
                                          : const Icon(
                                              Icons.favorite_border,
                                              size: 28,
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // orderBy is compulsary to enable pagination
                      query: FirebaseFirestore.instance
                          .collection('Restaurants')
                          .where('restVerified', isEqualTo: true)
                          .where('isTopPicked', isEqualTo: true)
                          .orderBy('restaurantName'),
                      listeners: [
                        refreshedChangeListener,
                      ],
                      footer: SliverToBoxAdapter(
                          child: Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Column(
                          children: [
                            Image.asset('images/City.png'),
                            RichText(
                              text: const TextSpan(
                                text: 'Thats All',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: ' Folks',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                      color: Color(0xFFFFC013),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
                    ),
                    onRefresh: () async {
                      refreshedChangeListener.refreshed = true;
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
