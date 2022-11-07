import 'package:babble_chat_app/screens/chat_screen/components/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget chatlist() {
  return Container(
    padding: EdgeInsets.only(left: 25, right: 25),
    child: ListView.separated(
        itemBuilder: (context, index) => ListTile(
              onTap: () => Get.offAll(() => ChatScreen()),
              leading: const CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage('assets/images/placeholder.png'),
              ),
              title: Text('User${index}'),
              subtitle: Text('message${index}'),
              trailing: Text('Last seen'),
            ),
        separatorBuilder: (context, index) => Divider(),
        itemCount: 30),
  );
}
