import 'package:babble_chat_app/controllers/authcontroller.dart';
import 'package:babble_chat_app/screens/home_screen/home_screen.dart';
import 'package:babble_chat_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var authController = AuthController();

    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Form(
                key: authController.formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your Username";
                        } else if (value.length < 5) {
                          return "Username must have atleast 5 characters";
                        } else {
                          return null;
                        }
                      },
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
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your phone number";
                        } else if (value.length != 10) {
                          return "Please enter a valid phone number";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.number,
                      controller: authController.phoneController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone_android_outlined),
                        prefixText: '+91',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        labelText: 'Phone Number',
                      ),
                    ),
                  ],
                )),
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
            SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () {
                  Get.offAll(() => HomeScreen());
                },
                child: Text('Go To Home')),
            Spacer(),
            Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 250,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 90, 11, 70)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ))),
                    onPressed: () async {
                      if (authController.formKey.currentState!.validate()) {
                        if (authController.isOtpSent.value == false) {
                          authController.isOtpSent.value = true;
                          await authController.sentOtp();
                        } else {
                          authController.verifyOtp();
                        }
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
