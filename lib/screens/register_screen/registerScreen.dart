// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:fuelapp/firebase/firebase.register.dart';
import 'package:fuelapp/screens/login_screen/loginscreen.dart';
import 'package:fuelapp/widgets/cutomTextfeild.dart';
import 'package:get/get.dart';

import '../../widgets/top_image.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  final userRegister controller = Get.put(userRegister());

  callBack(String value) {
    if (value == 'success') {
      Get.snackbar('Success', 'Register success',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return const LoginScreen();
          },
        ),
      );
    } else if (value == 'weak-password') {
      Get.snackbar('Warning', 'The password provided is too weak.',
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    } else if (value == 'email-already-in-use') {
      Get.snackbar('Warning', 'The account already exists for that email.',
          backgroundColor: Colors.orange,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                        'Register',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: SizedBox(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Create Account",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 1, 18, 33)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: CustomTextFeild(
                        controller: firstNameController,
                        placeholder: "enter first name",
                        titile: "First name",
                        type: 'user',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: CustomTextFeild(
                        controller: lastNameController,
                        placeholder: "enter last name",
                        titile: "Last name",
                        type: 'user',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: CustomTextFeild(
                        controller: emailController,
                        placeholder: "Email",
                        titile: "Email",
                        type: 'email',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: CustomTextFeild(
                        controller: passwordController,
                        placeholder: "enter password",
                        titile: "Password",
                        type: 'password',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: CustomTextFeild(
                        controller: confirmpasswordController,
                        placeholder: "confirm password",
                        titile: "Confirm password",
                        type: 'password',
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: SizedBox(
                          width: 300,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 243, 86, 33),
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            onPressed: () {
                              if (firstNameController.text.isEmpty ||
                                  lastNameController.text.isEmpty ||
                                  emailController.text.isEmpty ||
                                  passwordController.text.isEmpty ||
                                  confirmpasswordController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text('please fill all the field'),
                                  ),
                                );
                              } else {
                                controller.registerAccount(
                                  emailController.text,
                                  firstNameController.text,
                                  lastNameController.text,
                                  passwordController.text,
                                  callBack,
                                );
                              }
                            },
                            child: Obx(
                              () {
                                return controller.isLoading.value
                                    ? const Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 20,
                                              height: 20,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 1.5,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 15),
                                              child: Text(
                                                'Loading...',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily:
                                                      'Montserrat-Light',
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : const Text(
                                        'Register',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Montserrat-Light',
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                            child: Text(
                          'Already have an account? ',
                          style: TextStyle(
                              fontFamily: 'Roboto-Light',
                              fontSize: 18,
                              color: Theme.of(context).colorScheme.onSurface),
                        )),
                        Center(
                          child: InkWell(
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 35, 28, 239),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Roboto-Bold'),
                            ),
                            onTap: () => {Navigator.pop(context)},
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
