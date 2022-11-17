import 'package:babble_chat_app/controllers/authcontroller.dart';
import 'package:babble_chat_app/controllers/home_controller.dart';
import 'package:babble_chat_app/screens/compose_screen/compose_screen.dart';
import 'package:babble_chat_app/screens/home_screen/components/appbar.dart';
import 'package:babble_chat_app/screens/home_screen/components/chat_isttile.dart';
import 'package:babble_chat_app/screens/home_screen/components/drawer.dart';
import 'package:babble_chat_app/screens/signup_screen.dart';
import 'package:babble_chat_app/services/store_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var homeController = Get.put(HomeController());
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Container(
      color: Colors.white,
      child: Scaffold(
        key: scaffoldKey,
        drawer: drawer(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 90, 11, 70),
          onPressed: () {
            Get.to(() => ComposeScreen());
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
            Expanded(
                child: StreamBuilder(
                    stream: StoreServices.getMessages(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.black),
                          ),
                        );
                      } else if (snapshot.data!.docs.isEmpty) {
                        return Center(
                          child: Text("Start messaging..."),
                        );
                      } else {
                        return ListView(
                          children: snapshot.data!.docs
                              .mapIndexed((currentValue, index) {
                            var doc = snapshot.data!.docs[index];
                            return chatlist(doc);
                          }).toList(),
                        );
                      }
                    }))
          ],
        ),
      ),
    );
  }
}
