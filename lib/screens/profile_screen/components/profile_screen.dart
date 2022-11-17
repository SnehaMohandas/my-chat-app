import 'dart:io';

import 'package:babble_chat_app/controllers/authcontroller.dart';
import 'package:babble_chat_app/controllers/firebase_const.dart';
import 'package:babble_chat_app/controllers/profile_controller.dart';
import 'package:babble_chat_app/screens/home_screen/home_screen.dart';
import 'package:babble_chat_app/screens/profile_screen/components/picker_dialog.dart';
import 'package:babble_chat_app/services/store_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileScreen extends GetView<AuthController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get.put(AuthController());
    var profileController = Get.put(ProfileController());

    print('p build');
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.offAll(() => HomeScreen());
            },
            icon: Icon(Icons.arrow_back)),
        elevation: 0,
        //  centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(fontSize: 28),
        ),
        backgroundColor: Color.fromARGB(255, 90, 11, 70),
        actions: [
          TextButton(
              onPressed: () async {
                if (profileController.imagePath.isEmpty) {
                  profileController.updateProfile();
                } else {
                  await profileController.uploadImage();
                  profileController.updateProfile();
                }
              },
              child: const Text(
                'Save',
                style: TextStyle(
                    color: Color.fromARGB(255, 241, 231, 231), fontSize: 16),
              ))
        ],
      ),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          child: FutureBuilder(
              future: StoreServices.getUser(auth.currentUser!.uid),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data!.docs[0];

                  profileController.nameController.text = data['name'];
                  profileController.phoneController.text = data['phone'];
                  profileController.aboutController.text = data['about'];

                  // if (data.toString().contains('about')) {
                  //   profileController.aboutController.text = data['about'];
                  // } else {
                  //   profileController.aboutController.text = '';
                  // }

                  return Stack(children: [
                    Positioned(
                      child: Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(200)),
                            color: Color.fromARGB(255, 90, 11, 70)),
                        height: 160,
                      ),
                    ),
                    Positioned(
                      left: 125,
                      top: 60,
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(300)),
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(62))),
                            child: Obx(
                              () => CircleAvatar(
                                radius: 62,
                                backgroundColor: Colors.white,
                                backgroundImage:
                                    profileController.imagePath.isEmpty &&
                                            data['image_url'] == ''
                                        ? const AssetImage(
                                            'assets/images/placeholder.png')
                                        : profileController.imagePath.isNotEmpty
                                            ? Image.file(File(profileController
                                                    .imagePath.value))
                                                .image
                                            : NetworkImage(data['image_url']),
                                child: Stack(
                                  children: [
                                    Positioned(
                                        right: 0,
                                        bottom: 0,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          child: IconButton(
                                            onPressed: () {
                                              Get.dialog(pickerDialog(
                                                  context, profileController));
                                            },
                                            icon: const Icon(
                                              Icons.camera_alt_sharp,
                                              color: Colors.black,
                                              size: 24,
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        top: 250,
                        child: Container(
                          height: 400,
                          width: 400,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12, right: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  leading: Icon(Icons.person),
                                  title: TextFormField(
                                    controller:
                                        profileController.nameController,
                                    cursorColor: Colors.black,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        label: Text('Name'),
                                        labelStyle:
                                            TextStyle(color: Colors.black)),
                                  ),
                                  subtitle: const Text(
                                    'This is your username .This name will be visible to your BabbleChat contacts.',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  trailing: Icon(
                                    Icons.edit,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                ListTile(
                                    leading: Icon(Icons.info),
                                    title: TextFormField(
                                      //onSaved: profileController.updateProfile(),
                                      controller:
                                          profileController.aboutController,

                                      cursorColor: Colors.black,
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          label: Text('About'),
                                          labelStyle: TextStyle(
                                            color: Colors.black,
                                          )),
                                    ),
                                    trailing: Icon(
                                      Icons.edit,
                                    )),
                                SizedBox(
                                  height: 10,
                                ),
                                ListTile(
                                    leading: Icon(Icons.phone),
                                    title: TextField(
                                      controller:
                                          profileController.phoneController,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          labelText: 'Phone Number',
                                          labelStyle:
                                              TextStyle(color: Colors.black)),
                                    )),
                              ],
                            ),
                          ),
                        ))
                  ]);
                } else {
                  return Center(
                      child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.black),
                  ));
                }
              })),
    );
  }
}
