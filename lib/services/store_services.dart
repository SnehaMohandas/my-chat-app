import 'package:babble_chat_app/controllers/chat_controller.dart';
import 'package:babble_chat_app/controllers/firebase_const.dart';
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

  static getChats(String chatId) {
    return firebaseFirestore
        .collection(collectionChat)
        .doc(chatId)
        .collection(collectionMessage)
        .orderBy('created_on', descending: false)
        .snapshots();
  }

  static getMessages() {
    return firebaseFirestore
        .collection(collectionChat)
        .where("users.${currentUser!.uid}", isEqualTo: null)
        .where('last_msg', isNotEqualTo: '')
        .snapshots();
  }
}
