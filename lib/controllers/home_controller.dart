import 'package:babble_chat_app/controllers/firebase_const.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  static HomeController instance = Get.find();
  late SharedPreferences preferences;

  getUserDetails() async {
    await firebaseFirestore
        .collection(collectionUser)
        .where('id', isEqualTo: currentUser!.uid)
        .get()
        .then((value) async {
      preferences = await SharedPreferences.getInstance();
      preferences.setStringList(
          'user_details', [value.docs[0]['name'], value.docs[0]['image_url']]);
    });
  }

  @override
  void onInit() {
    getUserDetails();
    super.onInit();
  }
}
