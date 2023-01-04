import 'dart:io';
import 'package:babble_chat_app/controllers/firebase_const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController {
  var nameController = TextEditingController();
  var aboutController = TextEditingController();
  var phoneController = TextEditingController();
  var imagePath = ''.obs;
  var imageLink = '';

  updateProfile() async {
    var nameStore = await firebaseFirestore
        .collection(collectionUser)
        .doc(auth.currentUser!.uid);
    nameStore.set({
      'name': nameController.text,
      'about': aboutController.text,
    }, SetOptions(merge: true));
  }

  pickedImage(context, source) async {
    final image =
        await ImagePicker().pickImage(source: source, imageQuality: 80);

    try {
      if (image != null) {
        imagePath.value = image.path;
      }
    } on PlatformException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadImage() async {
    var name = basename(imagePath.value);
    var destination = 'images/${auth.currentUser!.uid}/$name';
    Reference reference =
        await FirebaseStorage.instance.ref().child(destination);
    await reference.putFile(File(imagePath.value));
    var link = await reference.getDownloadURL();
    imageLink = link;

    await firebaseFirestore
        .collection(collectionUser)
        .doc(auth.currentUser!.uid)
        .update({'image_url': imageLink});
  }
}
