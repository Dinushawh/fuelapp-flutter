import 'package:flutter/material.dart';
import 'package:fuelapp/core/utils/image_constant.dart';
import 'package:fuelapp/screens/login_screen/loginscreen.dart';
import 'package:fuelapp/widgets/top_image.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const TopContainer(),
            Column(
              children: <Widget>[
              Stack(
                
  children: [
    
    Image.asset(
      ImageConstant.image3, 
      width: 311.0,
      height: 227.0,
    ),
   
    Image.asset(
      ImageConstant.image4,
      width: 377.0,
    ),
  ],
),

                Padding(
                  padding: const EdgeInsets.only(top: 20,right: 60,left: 130),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(255, 243, 86, 33),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: Row(
                     
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30,right: 10,),
                          child: Text(
                            'Get Started',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              color: MediaQuery.of(context).platformBrightness ==
                                      Brightness.light
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios,size: 18,color: Colors.white,)
                      ],
                    ),
                    
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 101,
            )
          ],
        ),
      ),
    );
  }
}
