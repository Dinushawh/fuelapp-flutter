// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fuelapp/firebase/firebase.updateprofile.dart';
import 'package:fuelapp/screens/profile_screen/profileScreen.dart';
import 'package:fuelapp/widgets/cutomTextfeild.dart';
import 'package:fuelapp/widgets/top_image.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get_storage/get_storage.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController fnmae = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController passwd = TextEditingController();
  ImagePicker imagePicker = ImagePicker();
  final FirebaseStorage storage = FirebaseStorage.instance;
  late String imageUrl = '';
  late String filePath = '';
  late String fileName = '';
  final UpdateProfile updatePro = Get.put(UpdateProfile());
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                          'Edit Profile',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                          ),
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
                        100,
                      ),
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
                          uploadFile(filePath, fileName);
                        }
                      },
                      icon: const Icon(
                        Icons.camera_alt,
                        color: Colors.red,
                        size: 26,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: CustomTextFeild(
                controller: fnmae,
                placeholder: "Your name",
                titile: "",
                type: 'text',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: CustomTextFeild(
                controller: lname,
                placeholder: "Your Email",
                titile: "",
                type: 'text',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: CustomTextFeild(
                controller: email,
                placeholder: "Phone Number",
                titile: "",
                type: 'text',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: CustomTextFeild(
                controller: passwd,
                placeholder: "Password",
                titile: "",
                type: 'password',
              ),
            ),
            const SizedBox(
              height: 66,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  width: 300,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 243, 86, 33),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    onPressed: update,
                    child: Text(
                      'Update',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        color: MediaQuery.of(context).platformBrightness ==
                                Brightness.light
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 46,
            ),
          ],
        ),
      ),
    );
  }

  clearParameters() {
    imageUrl = '';
    filePath = '';
    fileName = '';
  }

  Future<void> uploadFile(String filePath, String fileName) async {
    File file = File(filePath);
    try {
      var uploadimg = await storage.ref('users/$fileName').putFile(file);
      String url = await (uploadimg).ref.getDownloadURL();
      setState(() {
        imageUrl = url;
      });
      print(url);
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  Future<void> update() async {
    await updatePro.updateUserData(
        imageUrl, fnmae.text, lname.text, email.text, passwd.text, callBack);
    clearParameters();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const ProfileScreen(),
      ),
    );
  }

  void callBack(String value) {
    if (value == 'success') {
      Get.snackbar('Success', 'Register success',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    } else {
      debugPrint(value);
      Get.snackbar('Error', 'Register failed',
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
