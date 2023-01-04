import 'package:babble_chat_app/controllers/firebase_const.dart';
import 'package:babble_chat_app/services/store_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget appbar(GlobalKey<ScaffoldState> key) {
  return Container(
    decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(35), bottomRight: Radius.circular(35)),
        color: Color.fromARGB(255, 90, 11, 70)),
    height: 130,
    padding: const EdgeInsets.only(right: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            onPressed: () {
              key.currentState!.openDrawer();
            },
            icon: const Icon(Icons.settings),
            color: Colors.white,
          ),
        ),
        RichText(
            text: const TextSpan(children: [
          TextSpan(
              text: 'BabbleChat\n',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold)),
          TextSpan(
              text: "                                  let's talk....",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15)),
        ])),
        FutureBuilder(
            future: StoreServices.getUser(auth.currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data!.docs[0];
                return CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: data['image_url'] == ''
                        ? const AssetImage('assets/images/placeholder.png')
                        : NetworkImage(data['image_url']) as ImageProvider);
              } else {
                return const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                );
              }
            })
      ],
    ),
  );
}
