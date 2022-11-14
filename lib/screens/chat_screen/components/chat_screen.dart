import 'dart:ffi';

import 'package:babble_chat_app/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  final String? userName;
  const ChatScreen({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 90, 11, 70),
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 80,
        backgroundColor: Color.fromARGB(255, 90, 11, 70),
        leading: IconButton(
            onPressed: () {
              Get.offAll(() => HomeScreen());
            },
            icon: Icon(Icons.arrow_back)),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_rounded))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                        text: '$userName\n',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500)),
                    TextSpan(
                        text: 'Last seen',
                        style: TextStyle(color: Colors.black, fontSize: 13))
                  ]))),
                  const Icon(
                    Icons.call,
                    size: 30,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 3, left: 3),
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 30,
                    itemBuilder: (context, index) => Directionality(
                          textDirection: index.isEven
                              ? TextDirection.ltr
                              : TextDirection.rtl,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 12),
                            child: Row(
                              children: [
                                const CircleAvatar(
                                  radius: 18,
                                  backgroundImage: AssetImage(
                                      'assets/images/placeholder.png'),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: Container(
                                    padding: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: index.isEven
                                            ? const Color.fromARGB(
                                                255, 207, 198, 198)
                                            : const Color.fromARGB(
                                                255, 133, 112, 136)),
                                    constraints: BoxConstraints(maxWidth: 210),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Hai akshay ",
                                          style: TextStyle(
                                            color: index.isEven
                                                ? Colors.black
                                                : Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                        Text(
                                          '10.00 AM',
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: index.isEven
                                                  ? const Color.fromARGB(
                                                      255, 66, 62, 62)
                                                  : const Color.fromARGB(
                                                      255, 240, 233, 233)),
                                          textAlign: TextAlign.right,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
              ),
            ),
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    child: TextField(
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
                          fontSize: 13,
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
                    backgroundColor: Color.fromARGB(255, 90, 11, 70),
                    child: IconButton(
                        onPressed: () {
                          print('object');
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
