import 'package:babble_chat_app/controllers/firebase_const.dart';
import 'package:babble_chat_app/screens/chat_screen/components/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

Widget chatlist(DocumentSnapshot doc) {
  var t =
      doc['created_on'] == null ? DateTime.now() : doc['created_on'].toDate();
  var time = intl.DateFormat("h.mma").format(t);
  var date = intl.DateFormat("d/M/yy").format(t);

  return Container(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: ListTile(
        onTap: () => Get.offAll(() => const ChatScreen(),
            transition: Transition.downToUp,
            arguments: [
              auth.currentUser!.uid == doc['fromId']
                  ? doc['friend_name']
                  : doc['user_name'],
              auth.currentUser!.uid == doc['fromId']
                  ? doc['toId']
                  : doc['fromId']
            ]),
        leading: const CircleAvatar(
          radius: 25,
          backgroundColor: Colors.white,
          backgroundImage: AssetImage('assets/images/placeholder.png'),
        ),
        title: auth.currentUser!.uid == doc['fromId']
            ? Text("${doc['friend_name']}")
            : Text("${doc['user_name']}"),
        subtitle: Text("${doc['last_msg']}"),
        trailing: Padding(
          padding: const EdgeInsets.only(top: 14, bottom: 9),
          child: Column(
            children: [Text(time, style: const TextStyle(fontSize: 12))],
          ),
        ),
      ));
}
