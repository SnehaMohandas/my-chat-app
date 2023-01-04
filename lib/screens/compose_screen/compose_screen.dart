import 'package:babble_chat_app/screens/chat_screen/components/chat_screen.dart';
import 'package:babble_chat_app/screens/home_screen/home_screen.dart';
import 'package:babble_chat_app/services/store_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ComposeScreen extends StatelessWidget {
  const ComposeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 90, 11, 70),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 90, 11, 70),
        elevation: 0,
        leading: const Icon(Icons.arrow_back).onTap(() {
          Get.offAll(() => const HomeScreen());
        }),
        centerTitle: true,
        title: const Text(
          'New Message',
          style: TextStyle(fontWeight: FontWeight.w400),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            color: Colors.white),
        child: StreamBuilder(
            stream: StoreServices.getAllUser(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, mainAxisExtent: 180),
                  scrollDirection: Axis.vertical,
                  children:
                      snapshot.data!.docs.mapIndexed((currentValue, index) {
                    var doc = snapshot.data!.docs[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromARGB(255, 170, 164, 164)
                                    .withOpacity(0.2)),
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.white,
                                      backgroundImage: doc['image_url'] == ''
                                          ? const AssetImage(
                                              'assets/images/placeholder.png')
                                          : NetworkImage("${doc['image_url']}")
                                              as ImageProvider),
                                  Text("${doc['name']}")
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(
                                          255, 120, 90, 129),
                                      padding: const EdgeInsets.only(
                                          right: 10, left: 10)),
                                  onPressed: () {
                                    Get.offAll(() => const ChatScreen(),
                                        transition: Transition.downToUp,
                                        arguments: [
                                          doc['name'],
                                          doc['id'],
                                        ]);
                                  },
                                  icon: const Icon(Icons.message),
                                  label: const Text('Message'))
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.black),
                  ),
                );
              }
            }),
      ),
    );
  }
}
