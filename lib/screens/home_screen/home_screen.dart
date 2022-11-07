import 'package:babble_chat_app/controllers/authcontroller.dart';
import 'package:babble_chat_app/screens/home_screen/components/appbar.dart';
import 'package:babble_chat_app/screens/home_screen/components/chat_isttile.dart';
import 'package:babble_chat_app/screens/home_screen/components/drawer.dart';
import 'package:babble_chat_app/screens/signup_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Container(
      color: Colors.white,
      child: Scaffold(
        key: scaffoldKey,
        drawer: drawer(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 90, 11, 70),
          onPressed: () {
            Get.offAll(() => SignupScreen());
          },
          child: Icon(Icons.add),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            appbar(scaffoldKey),
            const Padding(
              padding: const EdgeInsets.only(
                left: 40,
                top: 25,
              ),
              child: Text(
                'Chat List',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(child: chatlist())
          ],
        ),
      ),
    );
  }
}
