// ignore_for_file: prefer_interpolation_to_compose_strings, file_names, avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fuelapp/firebase/firebase.getFavoritesForuser.dart';
import 'package:fuelapp/widgets/top_image.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';

class Userfav extends StatefulWidget {
  const Userfav({super.key});

  @override
  State<Userfav> createState() => _UserfavState();
}

class _UserfavState extends State<Userfav> {
  final GetFavouritesController getFav = Get.put(GetFavouritesController());
  double count = 0;

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
                        'My Favourites',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 500,
            child: SingleChildScrollView(
              child: FutureBuilder<QuerySnapshot>(
                future: getFav.getuserFav(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData) {
                    return const Text('No reviews found');
                  } else {
                    return Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            count += snapshot.data!.docs[index]['points'];
                            print(count);
                            return Column(
                              children: [
                                Container(
                                  height: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Stack(children: [
                                    Positioned(
                                        top: 20,
                                        left: 20,
                                        child: Text(
                                          snapshot.data!.docs[index]['name'] +
                                              " " +
                                              DateFormat('yyyy-MM-dd').format(
                                                  snapshot
                                                      .data!
                                                      .docs[index]
                                                          ['dateCreated']
                                                      .toDate()),
                                          style: const TextStyle(fontSize: 18),
                                        )),
                                    Positioned(
                                      top: 50,
                                      left: 15,
                                      child: RatingBar.builder(
                                        initialRating: snapshot
                                            .data!.docs[index]['rating'],
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          // Store the rating value
                                        },
                                      ),
                                    ),
                                    Positioned(
                                      top: 20,
                                      right: 20,
                                      child: IconButton(
                                        onPressed: () {
                                          getFav.deleteFav(
                                              snapshot.data!.docs[index].id);
                                          Get.snackbar(
                                              'Success', 'Review Deleted',
                                              backgroundColor: Colors.green,
                                              colorText: Colors.white,
                                              snackPosition:
                                                  SnackPosition.BOTTOM);
                                        },
                                        icon: const Icon(Icons.delete),
                                      ),
                                    ),
                                    Positioned(
                                      top: 100,
                                      left: 20,
                                      child: Row(children: [
                                        Text(
                                          snapshot.data!.docs[index]['email'],
                                          style: const TextStyle(
                                              color: Colors.red),
                                        ),
                                        const Text('-'),
                                        Text(snapshot.data!.docs[index]
                                            ['comment'])
                                      ]),
                                    ),
                                    Positioned(
                                      top: 150,
                                      left: 20,
                                      child: Row(children: [
                                        Text(
                                          snapshot.data!.docs[index]['points']
                                              .toString(),
                                          style: const TextStyle(
                                              color: Colors.red),
                                        ),
                                        const Text('-'),
                                        Text(snapshot.data!.docs[index]
                                            ['comment'])
                                      ]),
                                    ),
                                  ]),
                                ),
                                const Divider()
                              ],
                            );
                          },
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
          Center(
            child: Column(children: [
              const Text(
                "You can paid with your points",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              const Icon(Icons.assignment_turned_in,
                  color: Colors.red, size: 50),
              Text(
                "Your point - " + count.toString() + ' points',
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              const Text(
                "Point used - 0 points",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const Text(
                "Reward balance - 1100 pints",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
