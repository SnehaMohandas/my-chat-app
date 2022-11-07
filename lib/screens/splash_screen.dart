import 'package:babble_chat_app/controllers/authcontroller.dart';
import 'package:babble_chat_app/controllers/profile_controller.dart';
import 'package:babble_chat_app/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get.put(AuthController());
    //Get.put(ProfileController());
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              // Get.offAll(() => SignupScreen());
            },
            child: Text('Signup')),
      ),
    );
  }
}
