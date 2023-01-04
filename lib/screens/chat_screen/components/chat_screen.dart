import 'package:babble_chat_app/controllers/chat_controller.dart';
import 'package:babble_chat_app/screens/chat_screen/components/chat_bubble.dart';
import 'package:babble_chat_app/screens/home_screen/home_screen.dart';
import 'package:babble_chat_app/services/store_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var chatController = Get.put(ChatController());

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 90, 11, 70),
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 80,
        backgroundColor: const Color.fromARGB(255, 90, 11, 70),
        leading: IconButton(
            onPressed: () {
              Get.offAll(() => const HomeScreen());
            },
            icon: const Icon(Icons.arrow_back)),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.more_vert_rounded))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(50))),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 18, right: 15),
              child: Row(
                children: [
                  Expanded(
                      child: RichText(
                          text: TextSpan(children: [
                    TextSpan(
                        text: "${chatController.feiendName}\n",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 23,
                            fontWeight: FontWeight.w500)),
                  ]))),
                  const Icon(
                    Icons.call,
                    size: 30,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Obx(
              () => Expanded(
                  child: chatController.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.black),
                        ))
                      : StreamBuilder(
                          stream: StoreServices.getChats(chatController.chatId),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData) {
                              return ListView(
                                children: snapshot.data!.docs
                                    .mapIndexed((currentValue, index) {
                                  var doc = snapshot.data!.docs[index];
                                  return chatBubble(index, doc);
                                }).toList(),
                              );
                            } else {
                              return Container();
                            }
                          })),
            ),
            SizedBox(
              height: 58,
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    child: TextField(
                      controller: chatController.messageController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                width: 0.9,
                                color: Color.fromARGB(255, 92, 88, 88))),
                        prefixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.emoji_emotions,
                            color: Color.fromARGB(255, 148, 145, 145),
                          ),
                        ),
                        hintText: 'Type something....',
                        hintStyle: const TextStyle(
                          fontSize: 14,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      cursorColor: Colors.black,
                    ),
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    backgroundColor: const Color.fromARGB(255, 90, 11, 70),
                    child: IconButton(
                        onPressed: () {
                          chatController.sendMessage(
                              chatController.messageController.text);
                        },
                        icon: const Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 19,
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
