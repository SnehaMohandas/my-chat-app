import 'package:babble_chat_app/controllers/authcontroller.dart';
import 'package:babble_chat_app/controllers/firebase_const.dart';
import 'package:babble_chat_app/screens/profile_screen/components/profile_screen.dart';
import 'package:babble_chat_app/services/store_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget drawer() {
  return Drawer(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(25))),
    child: Column(
      children: [
        const SizedBox(
          height: 25,
        ),
        ListTile(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios_new_outlined)),
          title: const Text(
            'Settings',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        FutureBuilder(
          future: StoreServices.getUser(auth.currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data!.docs[0];
              return Container(
                child: Column(
                  children: [
                    CircleAvatar(
                        radius: 48,
                        backgroundColor: Colors.white,
                        backgroundImage: data['image_url'] == ''
                            ? const AssetImage('assets/images/placeholder.png')
                            : NetworkImage(data['image_url']) as ImageProvider),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${data['name']}",
                      style: const TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ],
                ),
              );
            } else {
              return const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.black),
              );
            }
          },
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider(height: 5),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: ListTile(
            onTap: () {
              Get.offAll(() => const ProfileScreen());
            },
            leading: const Icon(Icons.key),
            title: const Text('Account'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: ListTile(
            onTap: () async {
              await AuthController.instance.signOut();
            },
            leading: const Icon(Icons.logout),
            title: const Text('LogOut'),
          ),
        )
      ],
    ),
  );
}
