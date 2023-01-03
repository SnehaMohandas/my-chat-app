import 'package:babble_chat_app/controllers/firebase_const.dart';
import 'package:babble_chat_app/screens/home_screen/home_screen.dart';
import 'package:babble_chat_app/screens/splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  late Rx<User?> firebaseUser;

  var userController = TextEditingController();
  var phoneController = TextEditingController();
  final otpController = List.generate(6, (index) => TextEditingController());

  var isOtpSent = false.obs;
  var formKey = GlobalKey<FormState>();
  String verificationID = '';

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _initialScreen);
  }

  _initialScreen(User? user) async {
    if (user == null) {
      Get.offAll(() => const SplashScreen());
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }

  sentOtp() async {
    await auth.verifyPhoneNumber(
      timeout: const Duration(seconds: 60),
      phoneNumber: '+91${phoneController.text}',
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
      },
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

      final User? user = (await auth.signInWithCredential(credential)).user;

      if (user != null) {
        DocumentReference store =
            FirebaseFirestore.instance.collection(collectionUser).doc(user.uid);
        await store.set({
          'id': user.uid,
          'name': userController.text.toString(),
          'phone': phoneController.text.toString(),
          'about': '',
          'image_url': ''
        }, SetOptions(merge: true));
      }
    } catch (e) {
      Get.snackbar('Error', 'Error occuring when sending OTP');
    }
  }

  signOut() async {
    auth.signOut();
    userController.text = '';
    phoneController.text = '';
    isOtpSent.value = false;
    for (var i = 0; i < otpController.length; i++) {
      otpController[i].text = '';
    }
  }
}
