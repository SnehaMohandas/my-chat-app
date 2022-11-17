import 'package:babble_chat_app/controllers/firebase_const.dart';
import 'package:babble_chat_app/controllers/home_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatController extends GetxController {
  //static ChatController instance = Get.find();
  //variables for chat
  dynamic chatId;
  var chats = firebaseFirestore.collection(collectionChat);
  var username =
      HomeController.instance.preferences.getStringList('user_details')![0];
  var userId = currentUser!.uid;
  var userphone = currentUser!.phoneNumber;
  var feiendName = Get.arguments[0];
  var friendId = Get.arguments[1];
  var friendPhone = Get.arguments[2];
  var isLoading = false.obs;

  var messageController = TextEditingController();

  getChatId() async {
    isLoading(true);
    await chats
        .where('users', isEqualTo: {friendId: null, userId: null})
        .limit(1)
        .get()
        .then((QuerySnapshot snapshot) async {
          if (snapshot.docs.isNotEmpty) {
            chatId = snapshot.docs.single.id;
          } else {
            chats.add({
              'users': {userId: null, friendId: null},
              'friend_name': feiendName,
              'user_name': username,
              'toId': '',
              'fromId': '',
              'created_on': null,
              'last_msg': ''
            }).then((value) {
              {
                chatId = value.id;
              }
            });
          }
        });
    isLoading(false);
  }

  sendMessage(String msg) {
    if (msg.trim().isNotEmptyAndNotNull) {
      chats.doc(chatId).update({
        'created_on': FieldValue.serverTimestamp(),
        'last_msg': msg,
        'toId': friendId,
        'fromId': userId
      });
      chats.doc(chatId).collection(collectionMessage).doc().set({
        'created_on': FieldValue.serverTimestamp(),
        'msg': msg,
        'uid': userId
      }).then((value) {
        messageController.clear();
      });
    }
  }

  @override
  void onInit() {
    getChatId();
    super.onInit();
  }
}
