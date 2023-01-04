import 'package:babble_chat_app/controllers/firebase_const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

Widget chatBubble(index, DocumentSnapshot doc) {
  var t =
      doc['created_on'] == null ? DateTime.now() : doc['created_on'].toDate();
  var time = intl.DateFormat("h.mma").format(t);
  return Directionality(
    textDirection: doc['uid'] == auth.currentUser!.uid
        ? TextDirection.rtl
        : TextDirection.ltr,
    child: Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          const SizedBox(
            width: 12,
          ),
          Directionality(
            textDirection: TextDirection.ltr,
            child: Container(
              padding: const EdgeInsets.only(
                  left: 12, right: 12, bottom: 8, top: 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: doc['uid'] == auth.currentUser!.uid
                      ? const Color.fromARGB(255, 207, 198, 198)
                      : const Color.fromARGB(255, 133, 112, 136)),
              constraints: const BoxConstraints(maxWidth: 210),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${doc['msg']}",
                    style: TextStyle(
                      color: doc['uid'] == auth.currentUser!.uid
                          ? Colors.black
                          : Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    time,
                    style: TextStyle(
                        fontSize: 9,
                        color: doc['uid'] == auth.currentUser!.uid
                            ? const Color.fromARGB(255, 66, 62, 62)
                            : const Color.fromARGB(255, 240, 233, 233)),
                    textAlign: TextAlign.right,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
