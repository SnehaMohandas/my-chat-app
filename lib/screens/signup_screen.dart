import 'package:babble_chat_app/controllers/authcontroller.dart';
import 'package:babble_chat_app/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var authController = Get.put(AuthController());
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: authController.userController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  labelText: 'Username',
                  prefixIcon: Icon(Icons.person)),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: authController.phoneController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.phone_android_outlined),
                prefixText: '+91',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                labelText: 'Phone Number',
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
                'We will send an SMS with a confirmation code to your phone number'),
            Obx(
              () => Visibility(
                visible: authController.isOtpSent.value,
                child: SizedBox(
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                        6,
                        (index) => SizedBox(
                              height: 65,
                              width: 50,
                              child: TextField(
                                controller: authController.otpController[index],
                                onChanged: (value) {
                                  if (value.length == 1 && index <= 5) {
                                    FocusScope.of(context).nextFocus();
                                  } else if (value.isEmpty && index < 0) {
                                    FocusScope.of(context).previousFocus();
                                  }
                                },
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    hintText: "*"),
                              ),
                            )),
                  ),
                ),
              ),
            ),
            Spacer(),
            Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 250,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 125, 22, 143)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(
                                        color: Color.fromARGB(
                                            255, 32, 126, 180))))),
                    onPressed: () async {
                      if (authController.isOtpSent.value == false) {
                        authController.isOtpSent.value = true;
                        await authController.sentOtp();
                      } else {
                        authController.verifyOtp();
                      }
                    },
                    child: Text('Continue'),
                  ),
                ))
          ],
        ),
      )),
    );
  }
}
