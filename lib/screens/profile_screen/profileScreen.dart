// ignore_for_file: file_names, prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fuelapp/firebase/firebase.updateprofile.dart';
import 'package:fuelapp/screens/edit_profile/edit_profile_screen.dart';
import 'package:fuelapp/screens/favourite_screen/favouriteScreen.dart';
import 'package:fuelapp/screens/recomondations_screen/recomondationscreen.dart';
import 'package:fuelapp/widgets/top_image.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../feedback_screen/feedbackscreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

final box = GetStorage();

class _ProfileScreenState extends State<ProfileScreen> {
    ImagePicker imagePicker = ImagePicker();
  final FirebaseStorage storage = FirebaseStorage.instance;
  late String imageUrl = '';
  late String filePath = '';
  late String fileName = '';
  final UpdateProfile updatePro = Get.put(UpdateProfile());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: <Widget>[
                  const TopContainer(),
                  Positioned(
                    top: 70,
                    left: 30,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Row(
                        children: [
                          Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black,
                            size: 20,
                          ),
                          Text(
                            'Profile',
                            style: TextStyle(
                                fontFamily: 'Poppins',fontSize: 24, fontWeight: FontWeight.w400,),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
               Center(
            child: Stack(
              children: [
                SizedBox(
                  width: 167,
                  height: 169,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        100), // Half of the container width or height
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: box.read('profilePicture').toString(),
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                                  value: downloadProgress.progress),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
                Positioned(
                    top: 130,
                    left: 100,
                    // ignore: avoid_unnecessary_containers
                    child: IconButton(
                        onPressed: () async {
                          final result = await imagePicker.pickImage(
                            source: ImageSource.gallery,
                          );

                          if (result != null) {
                            setState(() {
                              filePath = result.path;
                              fileName = result.path.split('/').last;
                            });
                            // uploadFile(filePath, fileName);
                          }
                        },
                        icon: const Icon(Icons.edit_square,color: Colors.red,size: 26,)))
              ],
            ),
          ),
              // Center(
              //   child: SizedBox(
              //     width: 169,
              //     height: 167,
              //     child: ClipRRect(
              //       borderRadius: BorderRadius.circular(100),
              //       child: CachedNetworkImage(
              //         fit: BoxFit.cover,
              //         imageUrl: box.read('profilePicture').toString(),
              //         progressIndicatorBuilder:
              //             (context, url, downloadProgress) =>
              //                 CircularProgressIndicator(
              //                     value: downloadProgress.progress),
              //         errorWidget: (context, url, error) => Icon(Icons.error),
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(height: 32,),
              Center(
                child: Column(children: [
                  Text(
                    "${box.read('fname')} ${box.read('lanme')}",
                    style: TextStyle( fontFamily: 'Poppins',fontSize: 32, fontWeight: FontWeight.w400,),
                  ),
                  Text(
                    box.read('email').toString(),
                    style: TextStyle( fontFamily: 'Poppins',fontSize: 16, fontWeight: FontWeight.w400,),
                  )
                ]),
              ),
              SizedBox(height: 20,),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 234, 73, 15),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditProfile(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 63),
                    child: Text(
                      'Edit Profile',
                      style: TextStyle(
                        fontSize: 20,
                       fontFamily: "Poppins",
                        color: MediaQuery.of(context).platformBrightness ==
                                Brightness.light
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 56,right: 44),
                child: Column(children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FeedBackScreen(),
                          ),
                        );
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Give feedback",
                            style: TextStyle( fontSize: 20,
                         fontFamily: "Poppins",fontWeight: FontWeight.w400),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                            ),
                          ),
                        ],
                      )),
                  const SizedBox(height: 10),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Userfav(),
                          ),
                        );
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "My favourite",
                            style: TextStyle( fontSize: 20,
                         fontFamily: "Poppins",fontWeight: FontWeight.w400),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                            ),
                          ),
                        ],
                      )),
                  const SizedBox(height: 10),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RecomondationScreen(),
                          ),
                        );
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Recommendations",
                            style: TextStyle( fontSize: 20,
                         fontFamily: "Poppins",fontWeight: FontWeight.w400),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                            ),
                          ),
                        ],
                      ),),
                  const SizedBox(height: 25),
                  const Divider(),
                  const SizedBox(height: 19),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "My fuel map",
                        style: TextStyle( fontSize: 20,
                         fontFamily: "Poppins",fontWeight: FontWeight.w400),
                      ),
                       Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                            ),
                          ),
                    ],
                  ),
                  SizedBox(height: 9,),
                  GestureDetector(
                      onTap: () {},
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Logout",
                            style: TextStyle(fontSize: 18,color: Color.fromARGB(255, 234, 73, 15),),
                          ),
                        ],
                      )),
                ]),
              ),
              SizedBox(
                height: 40,
              )
            ]),
      ),
    );
  }
}
