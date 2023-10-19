import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fuelapp/screens/home_screen/homescreen.dart';
import 'package:fuelapp/widgets/top_image.dart';

class FeedbackStep3 extends StatefulWidget {
  const FeedbackStep3({super.key});

  @override
  State<FeedbackStep3> createState() => _FeedbackStep3State();
}

class _FeedbackStep3State extends State<FeedbackStep3> {
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
                          'Give Feedback',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Center(
                  child: Container(
                    height: 531,
                    width: 390,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 9, vertical: 22),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 223, 218, 218),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 0, 0, 0)
                              .withOpacity(0.16),
                          offset: const Offset(0, 3),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/svg/svg2.svg',
                              height: 200,
                              width: 200,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Center(
                              child: Text(
                                'You Got',
                                style: TextStyle(fontSize: 24),
                              ),
                            ),
                            const Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '100 ',
                                    style: TextStyle(
                                        fontSize: 24,
                                        color:
                                            Color.fromARGB(255, 241, 78, 49)),
                                  ),
                                  Text(
                                    'Bonus Points',
                                    style: TextStyle(fontSize: 24),
                                  )
                                ],
                              ),
                            ),
                            const Center(
                              child: Text(
                                'We really appreciate your helping to improve the experience for everyone',
                                style: TextStyle(fontSize: 18),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ]),
                    ),
                  ),
                ),
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
                      backgroundColor: const Color.fromARGB(255, 243, 86, 33),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Home',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Roboto-Regular',
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
          ],
        ),
      ),
    );
  }
}
