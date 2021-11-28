import 'package:cloud_firestore/cloud_firestore.dart';

class userServices {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String collection = 'Users';

  //Get User by Emial
  Future<DocumentSnapshot> getUserByEmial(String email) async {
    var result = await _firestore.collection(collection).doc(email).get();
    return result;
  }
}
