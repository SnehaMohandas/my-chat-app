// import 'package:babble_chat_app/controllers/controller_.const.dart';
// import 'package:babble_chat_app/controllers/profile_controller.dart';
// import 'package:babble_chat_app/screens/home_screen/components/drawer.dart';
// import 'package:babble_chat_app/screens/home_screen/home_screen.dart';
// import 'package:babble_chat_app/services/store_services.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:get/get.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     var profileController = Get.put(ProfileCintroller());
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//             onPressed: () {
//               Get.offAll(() => HomeScreen());
//             },
//             icon: Icon(Icons.arrow_back)),
//         elevation: 0,
//         title: const Text(
//           'Profile',
//           style: TextStyle(fontSize: 28),
//         ),
//         backgroundColor: Color.fromARGB(255, 90, 11, 70),
//         actions: [
//           TextButton(
//               onPressed: () {
//                 profileController.updateProfile();
//               },
//               child: const Text(
//                 'Save',
//                 style: TextStyle(
//                     color: Color.fromARGB(255, 241, 231, 231), fontSize: 16),
//               ))
//         ],
//       ),
//       body: Container(
//           height: MediaQuery.of(context).size.height,
//           width: MediaQuery.of(context).size.width,
//           child: FutureBuilder(
//               future: StoreServices.getUser(currentUser!.uid),
//               builder: (BuildContext context,
//                   AsyncSnapshot<QuerySnapshot> snapshot) {
//                 if (snapshot.hasData) {
//                   var data = snapshot.data!.docs[0];
//                   profileController.nameController.text = data['name'];
//                   profileController.aboutController.text = data['about'];
//                   profileController.phoneController.text = data['phone'];

//                   return Stack(children: [
//                     Positioned(
//                       child: Container(
//                         decoration: const BoxDecoration(
//                             borderRadius: BorderRadius.vertical(
//                                 bottom: Radius.circular(200)),
//                             color: Color.fromARGB(255, 90, 11, 70)),
//                         height: 130,
//                       ),
//                     ),
//                     Positioned(
//                       left: 125,
//                       top: 50,
//                       child: Container(
//                         height: 150,
//                         width: 150,
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(300)),
//                         child: Align(
//                           alignment: Alignment.center,
//                           child: CircleAvatar(
//                             radius: 63,
//                             backgroundImage:
//                                 AssetImage('assets/images/placeholder.png'),
//                             child: Stack(
//                               children: [
//                                 Positioned(
//                                   right: 0,
//                                   bottom: 0,
//                                   // child: CircleAvatar(
//                                   //   backgroundColor: Colors.white,
//                                   child: IconButton(
//                                     splashColor: Colors.transparent,
//                                     onPressed: () {
//                                       print('hhh');
//                                     },
//                                     icon: const Icon(
//                                       Icons.camera_alt_rounded,
//                                       color: Colors.black,
//                                       size: 34,
//                                     ),
//                                   ),
//                                   //)
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                         top: 250,
//                         child: Container(
//                           height: MediaQuery.of(context).size.height,
//                           width: MediaQuery.of(context).size.width,
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 10, right: 10),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 ListTile(
//                                   leading: Icon(Icons.person),
//                                   title: TextFormField(
//                                     controller:
//                                         profileController.nameController,
//                                     cursorColor: Colors.black,
//                                     decoration: const InputDecoration(
//                                         border: InputBorder.none,
//                                         label: Text('Name'),
//                                         labelStyle:
//                                             TextStyle(color: Colors.black)),
//                                   ),
//                                   subtitle: const Text(
//                                     'This is your username .This name will be visible to your BabbleChat contacts.',
//                                     style: TextStyle(fontSize: 12),
//                                   ),
//                                   trailing: IconButton(
//                                       onPressed: () {}, icon: Icon(Icons.edit)),
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 ListTile(
//                                   leading: Icon(Icons.info),
//                                   title: TextFormField(
//                                     controller:
//                                         profileController.aboutController,
//                                     cursorColor: Colors.black,
//                                     decoration: const InputDecoration(
//                                         border: InputBorder.none,
//                                         label: Text('About'),
//                                         labelStyle: TextStyle(
//                                           color: Colors.black,
//                                         )),
//                                   ),
//                                   trailing: IconButton(
//                                       onPressed: () {}, icon: Icon(Icons.edit)),
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 ListTile(
//                                     leading: Icon(Icons.phone),
//                                     title: TextField(
//                                       controller:
//                                           profileController.phoneController,
//                                       decoration: InputDecoration(
//                                           border: InputBorder.none,
//                                           labelText: 'Phone Number',
//                                           labelStyle:
//                                               TextStyle(color: Colors.black)),
//                                     )),
//                               ],
//                             ),
//                           ),
//                         ))
//                   ]);
//                 } else {
//                   return Center(
//                       child: CircularProgressIndicator(
//                     valueColor: AlwaysStoppedAnimation(Colors.black),
//                   ));
//                 }
//               })),
//     );
//   }
// }
