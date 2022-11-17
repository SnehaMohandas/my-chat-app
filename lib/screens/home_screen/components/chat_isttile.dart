import 'package:babble_chat_app/screens/chat_screen/components/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

Widget chatlist(DocumentSnapshot doc) {
  var t =
      doc['created_on'] == null ? DateTime.now() : doc['created_on'].toDate();
  var time = intl.DateFormat("h.mma").format(t);

  return Container(
    padding: EdgeInsets.only(left: 25, right: 25),
    child:
        //  ListView.separated(
        //     itemBuilder: (context, index) =>
        ListTile(
      onTap: () => Get.offAll(() => ChatScreen(),
          transition: Transition.downToUp,
          arguments: ["Demo Username", "Demo UserId"]),
      leading: const CircleAvatar(
        radius: 25,
        backgroundColor: Colors.white,
        backgroundImage: AssetImage('assets/images/placeholder.png'),
      ),
      title: Text("${doc['friend_name']}"),
      subtitle: Text("${doc['last_msg']}"),
      trailing: Text("$time"),
    ),
    // separatorBuilder: (context, index) => Divider(),
    // itemCount: 30),
  );
}
