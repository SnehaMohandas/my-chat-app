import 'package:babble_chat_app/controllers/authcontroller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            const Text(
              'Sign up',
              style: TextStyle(
                  color: Color.fromARGB(255, 90, 11, 70),
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            Form(
                key: AuthController.instance.formKey,
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
                      controller: AuthController.instance.userController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          labelText: 'Username',
                          prefixIcon: const Icon(Icons.person)),
                    ),
                    const SizedBox(
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
                      controller: AuthController.instance.phoneController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.phone_android_outlined),
                        prefixText: '+91',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        labelText: 'Phone Number',
                      ),
                    ),
                  ],
                )),
            const SizedBox(
              height: 15,
            ),
            const Text(
                'We will send an SMS with a confirmation code to your phone number'),
            Obx(
              () => Visibility(
                visible: AuthController.instance.isOtpSent.value,
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
                                controller: AuthController
                                    .instance.otpController[index],
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
            const SizedBox(
              height: 20,
            ),
            const Spacer(),
            Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 230,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 90, 11, 70)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ))),
                    onPressed: () async {
                      if (AuthController.instance.formKey.currentState!
                          .validate()) {
                        if (AuthController.instance.isOtpSent.value == false) {
                          AuthController.instance.isOtpSent.value = true;
                          await AuthController.instance.sentOtp();
                        } else {
                          await AuthController.instance.verifyOtp();
                        }
                      }
                    },
                    child: const Text('Continue'),
                  ),
                ))
          ],
        ),
      )),
    );
  }
}
