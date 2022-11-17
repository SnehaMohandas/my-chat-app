import 'dart:io';

import 'package:babble_chat_app/controllers/firebase_const.dart';
import 'package:babble_chat_app/screens/profile_screen/components/profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController {
  // static ProfileController instance = Get.find();
  var nameController = TextEditingController();
  var aboutController = TextEditingController();
  var phoneController = TextEditingController();
  var imagePath = ''.obs;
  var imageLink = '';

  updateProfile() async {
    var nameStore =
        firebaseFirestore.collection(collectionUser).doc(currentUser!.uid);
    nameStore.set({
      'name': nameController.text,
      'about': aboutController.text,
      'image_url': imageLink
    }, SetOptions(merge: true));
  }

  // image picking method
  pickedImage(context, source) async {
    final image =
        await ImagePicker().pickImage(source: source, imageQuality: 80);

    try {
      if (image != null) {
        imagePath.value = image.path;
        print(imagePath.value);
      }
    } on PlatformException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadImage() async {
    print('upload image');
    var name = basename(imagePath.value);
    var destination = 'images/${currentUser!.uid}/$name';
    Reference reference =
        await FirebaseStorage.instance.ref().child(destination);
    await reference.putFile(File(imagePath.value));
    var link = await reference.getDownloadURL();
    imageLink = link;
    print(imageLink);
  }
}
