import 'package:babble_chat_app/controllers/authcontroller.dart';
import 'package:babble_chat_app/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AuthController());

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: Column(
          children: [
            const SizedBox(
              height: 250,
            ),
            Container(
              width: double.infinity,
              height: 300,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image: AssetImage(
                          'assets/images/2022-11-29-13-06-45-721.jpg'))),
            ),
            const Spacer(),
            SizedBox(
              width: 230,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 182, 159, 180)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ))),
                  onPressed: () {
                    Get.to(() => const SignupScreen());
                  },
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  )),
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ));
  }
}
