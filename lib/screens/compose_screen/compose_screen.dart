import 'package:babble_chat_app/controllers/chat_controller.dart';
import 'package:babble_chat_app/screens/chat_screen/components/chat_screen.dart';
import 'package:babble_chat_app/screens/home_screen/home_screen.dart';
import 'package:babble_chat_app/services/store_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ComposeScreen extends StatelessWidget {
  const ComposeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 90, 11, 70),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 90, 11, 70),
        elevation: 0,
        leading: Icon(Icons.arrow_back).onTap(() {
          Get.offAll(() => HomeScreen());
        }),
        centerTitle: true,
        title: Text(
          'New Message',
          style: TextStyle(fontWeight: FontWeight.w400),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            color: Colors.white),
        child: StreamBuilder(
            stream: StoreServices.getAllUser(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return GridView(
                  // shrinkWrap: true,
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
                        // child: Text("${doc['name']}"),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromARGB(255, 170, 164, 164)
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
                                          ? AssetImage(
                                              'assets/images/placeholder.png')
                                          : NetworkImage("${doc['image_url']}")
                                              as ImageProvider),
                                  Text("${doc['name']}")
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Color.fromARGB(255, 120, 90, 129),
                                      padding:
                                          EdgeInsets.only(right: 10, left: 10)),
                                  onPressed: () {
                                    Get.to(() => ChatScreen(),
                                        transition: Transition.downToUp,
                                        arguments: [
                                          doc['name'],
                                          doc['id'],
                                          doc['phone']
                                        ]);
                                  },
                                  icon: Icon(Icons.message),
                                  label: Text('Message'))
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
