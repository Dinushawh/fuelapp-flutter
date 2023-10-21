import 'package:flutter/material.dart';
import 'package:fuelapp/firebase/firebase.login.dart';
import 'package:fuelapp/screens/home_screen/homescreen.dart';
import 'package:fuelapp/screens/register_screen/registerScreen.dart';
import 'package:fuelapp/widgets/cutomTextfeild.dart';
import 'package:fuelapp/widgets/top_image.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final userLogin userlogin = Get.put(userLogin());

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
                     
  Navigator.of(context).pop();


                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                          size: 20,
                        ),
                        Text(
                          'Login',
                          style:
                              TextStyle( fontFamily: 'Poppins',fontSize: 24, fontWeight: FontWeight.w400, ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Center(
                child: Container(
                  height: 531,
                  width: 390,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 9, vertical: 22),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(123, 130, 130, 130),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color:
                            const Color.fromARGB(255, 0, 0, 0).withOpacity(0.16),
                        offset: const Offset(0, 3),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(children: [
                      const Text(
                        "Welcome",
                      ),
                      const Text(
                        "Fuel Finder",
                      ),
                      const SizedBox(height: 44),
                      CustomTextFeild(
                        controller: emailController,
                        placeholder: "Email",
                        titile: "Email",
                        type: 'email',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFeild(
                        controller: passwordController,
                        placeholder: "Password",
                        titile: "Password",
                        type: 'password',
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
                                userlogin.loginAccount(
                                  emailController.text,
                                  passwordController.text,
                                  (String response) {
                                    if (response == 'success') {
                                      Get.snackbar('Success', 'Login success',
                                          backgroundColor: Colors.green,
                                          colorText: Colors.white,
                                          snackPosition: SnackPosition.BOTTOM);
      
                                      Navigator.pushReplacement(
                                        context,
                                        PageRouteBuilder(
                                          transitionDuration:
                                              const Duration(milliseconds: 300),
                                          transitionsBuilder:
                                              (BuildContext context,
                                                  Animation<double> animation,
                                                  Animation<double>
                                                      secondaryAnimation,
                                                  Widget child) {
                                            return FadeTransition(
                                              opacity: animation,
                                              child: child,
                                            );
                                          },
                                          pageBuilder: (BuildContext context,
                                              Animation<double> animation,
                                              Animation<double>
                                                  secondaryAnimation) {
                                            return const HomeScreen();
                                          },
                                        ),
                                      );
                                    } else if (response == 'user-not-found') {
                                      Get.snackbar(
                                        'Error',
                                        'User not found',
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: Colors.red,
                                        colorText: Colors.white,
                                      );
                                    } else if (response == 'wrong-password') {
                                      Get.snackbar(
                                        'Error',
                                        'Invalid username or password',
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: Colors.red,
                                        colorText: Colors.white,
                                      );
                                    } else if (response == 'error') {
                                      Get.snackbar(
                                        'Error',
                                        'Something went wrong',
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: Colors.red,
                                        colorText: Colors.white,
                                      );
                                    }
                                  },
                                );
                              },
                              child: Obx(
                                () {
                                  return userlogin.isLoading.value
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
                                          'Login',
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
                            'Don\'t have an account? ',
                            style: TextStyle(
                                fontFamily: 'Roboto-Light',
                                fontSize: 18,
                                color: Theme.of(context).colorScheme.onSurface),
                          )),
                          Center(
                            child: InkWell(
                              child: const Text(
                                'Sign up',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 35, 28, 239),
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Roboto-Bold'),
                              ),
                              onTap: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const RegisterScreen(),
                                  ),
                                )
                              },
                            ),
                          ),
                        ],
                      ),
                    ]),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
