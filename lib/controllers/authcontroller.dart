import 'package:babble_chat_app/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  User? currentUser = FirebaseAuth.instance.currentUser;
  var collectionUser = 'users';
  var userController = TextEditingController();
  var phoneController = TextEditingController();
  final otpController = List.generate(6, (index) => TextEditingController());

  var isOtpSent = false.obs;

  String verificationID = '';

  sentOtp() async {
    await auth.verifyPhoneNumber(
      timeout: const Duration(seconds: 60),
      phoneNumber: '+91${phoneController.text}',
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        Get.snackbar('Error', 'Problem when send the OTP');
      },
      codeSent: (String verificationId, [int? resendtoken]) {
        verificationID = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }

  verifyOtp() async {
    String otp = '';
    for (var i = 0; i < otpController.length; i++) {
      otp += otpController[i].text;
    }

    try {
      PhoneAuthCredential credential = await PhoneAuthProvider.credential(
          verificationId: verificationID, smsCode: otp);

      final User? userData = (await auth.signInWithCredential(credential)).user;

      if (userData != null) {
        DocumentReference store = FirebaseFirestore.instance
            .collection(collectionUser)
            .doc(userData.uid);
        await store.set({
          'id': userData.uid,
          'name': userController.text.toString(),
          'phone': phoneController.text.toString()
        });

        Get.offAll(() => HomeScreen());
      }
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error', 'Error occuring when verifying OTP');
    }
  }
}
