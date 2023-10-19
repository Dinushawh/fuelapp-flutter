// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fuelapp/firebase/firebase.getAllFeedbacks.dart';
import 'package:fuelapp/widgets/top_image.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RecomondationScreen extends StatefulWidget {
  const RecomondationScreen({super.key});

  @override
  State<RecomondationScreen> createState() => _RecomondationScreenState();
}

class _RecomondationScreenState extends State<RecomondationScreen> {
  final getcartController getfeedbackss = Get.put(getcartController());
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
                        'Recomondations',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SingleChildScrollView(
            child: StreamBuilder<QuerySnapshot>(
              stream: getfeedbackss.getAllFeedbacks(),
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
                                    child: SizedBox(
                                      width: 70,
                                      height: 70,
                                      child: ClipRRect(
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl: snapshot
                                              .data!.docs[index]['image']
                                              .toString(),
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              CircularProgressIndicator(
                                                  value: downloadProgress
                                                      .progress),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      top: 20,
                                      left: 110,
                                      child: Text(
                                        snapshot.data!.docs[index]['name'],
                                        style: TextStyle(fontSize: 18),
                                      )),
                                  Positioned(
                                    top: 45,
                                    left: 100,
                                    child: RatingBar.builder(
                                      initialRating: snapshot.data!.docs[index]
                                          ['rating'],
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
                                    child: Text(DateFormat('yyyy-MM-dd').format(
                                        snapshot
                                            .data!.docs[index]['dateCreated']
                                            .toDate())),
                                  ),
                                  Positioned(
                                    top: 100,
                                    left: 20,
                                    child: Row(children: [
                                      Text(
                                        snapshot.data!.docs[index]['email'],
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      Text('-'),
                                      Text(
                                          snapshot.data!.docs[index]['comment'])
                                    ]),
                                  ),
                                ]),
                              ),
                              Divider()
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
        ],
      ),
    );
  }
}
