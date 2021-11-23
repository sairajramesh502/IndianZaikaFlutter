// ignore_for_file: unused_field, avoid_print

import 'package:flutter/material.dart';
import 'package:indian_zaika/constants/constants.dart';
import 'package:indian_zaika/providers/auth_provider.dart';
import 'package:indian_zaika/providers/location_provider.dart';
import 'package:indian_zaika/screens/home_screen.dart';
import 'package:indian_zaika/widgets/button.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shimmer/shimmer.dart';

class MapScreen extends StatefulWidget {
  static const String id = 'map-screen';
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late LatLng currentLocation;
  late GoogleMapController _mapController;
  String featureName = '';
  String addressline = '';
  bool isLoading = false;

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
    final _mapScreenProvider = Provider.of<LocationProvider>(context);
    final _mapScreenAuthProvider = Provider.of<AuthenticationHelper>(context);

    setState(() {
      currentLocation =
          LatLng(_mapScreenProvider.latitude, _mapScreenProvider.longitude);
    });

    void onCreated(GoogleMapController controller) {
      setState(() {
        _mapController = controller;
      });
    }

    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: SafeArea(
          child: Stack(
            children: [
              GoogleMap(
                initialCameraPosition:
                    CameraPosition(target: currentLocation, zoom: 19),
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                zoomControlsEnabled: false,
                minMaxZoomPreference: const MinMaxZoomPreference(1.5, 20.8),
                mapType: MapType.normal,
                onCameraMove: (CameraPosition position) {
                  setState(() {
                    isLoading = true;
                  });
                  _mapScreenProvider.onCameraMove(position);
                },
                onMapCreated: onCreated,
                onCameraIdle: () {
                  _mapScreenProvider.getCameraMove().then((address) {
                    setState(() {
                      featureName =
                          _mapScreenProvider.selectedAddress.featureName;
                      addressline =
                          _mapScreenProvider.selectedAddress.addressLine;
                    });
                  });
                  setState(() {
                    isLoading = false;
                  });
                },
              ),
              Center(
                child: Image.asset(
                  'images/locationPin.gif',
                  width: 70,
                  height: 70,
                ),
              ),
              Positioned(
                bottom: 0.0,
                child: Container(
                  width: screenWidth,
                  height: screenHeight / 3,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(44),
                      topRight: Radius.circular(44),
                    ),
                    color: Color(0xFF272C2F),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 35, right: 35, top: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Selected Location',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        isLoading
                            ? Shimmer.fromColors(
                                baseColor: kCardBackColor,
                                highlightColor: kShimmerHighlight,
                                child: Container(
                                  height: 28,
                                  width: screenWidth / 2.5,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: kCardBackColor,
                                  ),
                                ),
                              )
                            : Text(
                                featureName,
                                style: const TextStyle(
                                  color: kAccentColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1.2,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                        const SizedBox(
                          height: 10,
                        ),
                        isLoading
                            ? Shimmer.fromColors(
                                baseColor: kCardBackColor,
                                highlightColor: kShimmerHighlight,
                                child: Container(
                                  height: screenWidth / 9.4,
                                  width: screenWidth / 1.1,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: kCardBackColor,
                                  ),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Text(
                                  addressline,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: screenWidth / 9,
                        ),
                        isLoading
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
                                onPressed: () {
                                  print('Pressed');
                                  _mapScreenAuthProvider
                                      .updateUserLocation(
                                          longitude:
                                              _mapScreenProvider.longitude,
                                          latitude: _mapScreenProvider.latitude,
                                          address: addressline)
                                      .then((result) {
                                    if (result == null) {
                                      scaffoldMessage(
                                          'Location set Sucessfully');
                                      Navigator.pushReplacementNamed(
                                          context, HomeScreen.id);
                                    } else {
                                      scaffoldMessage(result);
                                    }
                                  });
                                },
                                buttonText: 'Set Location')
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
