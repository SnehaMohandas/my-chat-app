import 'package:babble_chat_app/screens/home_screen/components/drawer.dart';
import 'package:flutter/material.dart';

Widget appbar(GlobalKey<ScaffoldState> key) {
  return Container(
    decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(35), bottomRight: Radius.circular(35)),
        color: Color.fromARGB(255, 90, 11, 70)),
    height: 120,
    padding: EdgeInsets.only(right: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            onPressed: () {
              key.currentState!.openDrawer();
            },
            icon: Icon(Icons.settings),
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
        const CircleAvatar(
          backgroundImage: AssetImage('assets/images/placeholder.png'),
        ),
      ],
    ),
  );
}
