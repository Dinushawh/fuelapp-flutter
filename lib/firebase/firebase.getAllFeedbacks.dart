// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class getcartController extends GetxController {
  var isLoading = false.obs;

  Stream<QuerySnapshot> getAllFeedbacks() {
    Query query = FirebaseFirestore.instance.collection('feedback');

    return query.snapshots();
  }

  void deletecart(id) {
    FirebaseFirestore.instance.collection('cart').doc(id).delete();
  }
}
