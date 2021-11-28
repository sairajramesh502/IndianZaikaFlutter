import 'package:cloud_firestore/cloud_firestore.dart';

class StoreServices {
  getTopPickedRestaurant() {
    return FirebaseFirestore.instance
        .collection('Restaurants')
        .where('restVerified', isEqualTo: true)
        .where('isTopPicked', isEqualTo: true)
        .orderBy('restaurantName')
        .snapshots();
  }
}
