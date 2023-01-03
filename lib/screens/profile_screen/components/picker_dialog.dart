import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

Widget pickerDialog(context, controller) {
  var listText = ['Camera', 'Gallery', 'Cancel'];
  var icons = [Icons.camera_alt_rounded, Icons.photo_sharp, Icons.cancel];
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    child: Container(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Select Source',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            ListView(
              shrinkWrap: true,
              children: List.generate(
                3,
                (index) => ListTile(
                  onTap: () {
                    switch (index) {
                      case 0:
                        Get.back();
                        controller.pickedImage(context, ImageSource.camera);

                        break;
                      case 1:
                        Get.back();
                        controller.pickedImage(context, ImageSource.gallery);
                        break;
                      case 2:
                        Get.back();

                        break;
                      default:
                    }
                  },
                  leading: Icon(
                    icons[index],
                  ),
                  title: Text(listText[index]),
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
