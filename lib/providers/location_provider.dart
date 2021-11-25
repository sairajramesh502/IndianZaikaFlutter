// ignore_for_file: unnecessary_null_comparison, unnecessary_this, avoid_print, import_of_legacy_library_into_null_safe, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationProvider with ChangeNotifier {
  double latitude = 0.0;
  double longitude = 0.0;
  bool permisionAllowed = false;
  var selectedAddress;
  bool loading = false;

  Future<void> getCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    if (position != null) {
      this.latitude = position.latitude;
      this.longitude = position.longitude;
      final coordinates = Coordinates(this.latitude, this.longitude);
      final addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      this.selectedAddress = addresses.first;
      this.permisionAllowed = true;
      notifyListeners();
    } else {
      print('Permission Not Allowed');
    }
  }

  void onCameraMove(CameraPosition cameraPosition) {
    this.latitude = cameraPosition.target.latitude;
    this.longitude = cameraPosition.target.longitude;
    notifyListeners();
  }

  Future<void> getCameraMove() async {
    final coordinates = Coordinates(this.latitude, this.longitude);
    final addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    this.selectedAddress = addresses.first;
    print('${selectedAddress.featureName} : ${selectedAddress.addressLine}');
  }

  Future<void> savePrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('lat', this.latitude);
    prefs.setDouble('lng', this.longitude);
    prefs.setString('address', this.selectedAddress.addressLine);
    prefs.setString('featureName', this.selectedAddress.featureName);
  }
}
