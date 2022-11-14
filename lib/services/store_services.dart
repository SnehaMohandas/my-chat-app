import 'package:babble_chat_app/controllers/controller_.const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StoreServices {
  static getUser(String id) {
    return firebaseFirestore
        .collection(collectionUser)
        .where('id', isEqualTo: id)
        .get();
  }

  static getAllUser() {
    return firebaseFirestore.collection(collectionUser).snapshots();
  }
}
