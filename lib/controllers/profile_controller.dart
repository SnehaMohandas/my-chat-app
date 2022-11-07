import 'package:babble_chat_app/controllers/controller_.const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  //var nameController = TextEditingController();
  var aboutController = TextEditingController();
  //var phoneController = TextEditingController();

  // updateName(String name) async {
  //   var nameStore =
  //       firebaseFirestore.collection(collectionUser).doc(currentUser!.uid);
  //   await nameStore.set({'name': name}, SetOptions(merge: true));
  // }

  updateAbout() async {
    var aboutStore =
        firebaseFirestore.collection(collectionUser).doc(currentUser!.uid);
    await aboutStore
        .set({'about': aboutController.text}, SetOptions(merge: true));
  }
}
