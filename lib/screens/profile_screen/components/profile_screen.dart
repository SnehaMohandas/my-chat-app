import 'package:babble_chat_app/controllers/controller_.const.dart';
import 'package:babble_chat_app/controllers/profile_controller.dart';
import 'package:babble_chat_app/screens/home_screen/components/drawer.dart';
import 'package:babble_chat_app/screens/home_screen/home_screen.dart';
import 'package:babble_chat_app/screens/splash_screen.dart';
import 'package:babble_chat_app/services/store_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.find();
    var nameController = TextEditingController();
    print('profilescreen build');
    updateName(String uid) async {
      // var nameStore = FirebaseFirestore.instance
      //     .collection(collectionUser)
      //     .doc(currentUser!.uid);
      // await nameStore.set({'name': name}, SetOptions(merge: true));
      // print(name);
      Map<String, Object> map = {};
      map['name'] = nameController.text;
      await FirebaseFirestore.instance
          .collection(collectionUser)
          .doc(uid)
          .update(map);
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.offAll(() => HomeScreen());
            },
            icon: Icon(Icons.arrow_back)),
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(fontSize: 28),
        ),
        backgroundColor: Color.fromARGB(255, 90, 11, 70),
        actions: [
          TextButton(
              onPressed: () {},
              child: const Text(
                'Save',
                style: TextStyle(
                    color: Color.fromARGB(255, 241, 231, 231), fontSize: 16),
              ))
        ],
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: FutureBuilder(
              future: StoreServices.getUser(currentUser!.uid),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  // print('object');
                  //  var data = snapshot.data!.docs[0];
                  nameController.text = snapshot.data!.docs[0]['name'];
                  print(nameController.text);
                  //profileController.aboutController.text = data['about'];
                  // profileController.phoneController.text = data['phone'];

                  return Stack(children: [
                    Positioned(
                      child: Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(200)),
                            color: Color.fromARGB(255, 90, 11, 70)),
                        height: 130,
                      ),
                    ),
                    Positioned(
                      left: 125,
                      top: 50,
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(300)),
                        child: Align(
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            radius: 63,
                            backgroundImage:
                                AssetImage('assets/images/placeholder.png'),
                            child: Stack(
                              children: [
                                Positioned(
                                  right: 0,
                                  bottom: 0,
                                  // child: CircleAvatar(
                                  //   backgroundColor: Colors.white,
                                  child: IconButton(
                                    splashColor: Colors.transparent,
                                    onPressed: () {
                                      print('hhh');
                                    },
                                    icon: const Icon(
                                      Icons.camera_alt_rounded,
                                      color: Colors.black,
                                      size: 34,
                                    ),
                                  ),
                                  //)
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        top: 250,
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  leading: Icon(Icons.person),
                                  title: const Text(
                                    'Name',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  subtitle: Text(
                                    snapshot.data!.docs[0]['name'],
                                    //nameController.text,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                  trailing: IconButton(
                                      onPressed: () {
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: Column(
                                                  children: [
                                                    const Text(
                                                      'Edit your name',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    const SizedBox(
                                                      height: 30,
                                                    ),
                                                    TextFormField(
                                                      controller:
                                                          nameController,
                                                      decoration:
                                                          const InputDecoration(
                                                              labelText: 'Name',
                                                              labelStyle: TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          90,
                                                                          11,
                                                                          70))),
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);

                                                        updateName(snapshot
                                                            .data!.docs[0].id);
                                                        print(nameController
                                                            .text);
                                                      },
                                                      child: Text(
                                                        'Save',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                      style: const ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStatePropertyAll(
                                                                  Color
                                                                      .fromARGB(
                                                                          255,
                                                                          90,
                                                                          11,
                                                                          70))),
                                                    )
                                                  ],
                                                ),
                                              );
                                            });
                                      },
                                      icon: Icon(Icons.edit)),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 75, right: 75),
                                  child: SizedBox(
                                    height: 40,
                                    child: Text(
                                      'This is your username. This name will be visible to your BabbleChat contacts',
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ListTile(
                                  leading: const Icon(Icons.info),
                                  title: const Text(
                                    'About',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  subtitle: Text(
                                    snapshot.data!.docs[0]['about'],
                                    style: const TextStyle(
                                        fontSize: 17, color: Colors.black),
                                  ),
                                  trailing: IconButton(
                                      onPressed: () {}, icon: Icon(Icons.edit)),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ListTile(
                                  leading: const Icon(Icons.phone),
                                  title: const Text(
                                    'Phone Number',
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  subtitle: Text(
                                    snapshot.data!.docs[0]['phone'],
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ))
                  ]);
                } else {
                  return const Center(
                      child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.black),
                  ));
                }
              })),
    );
  }
}
