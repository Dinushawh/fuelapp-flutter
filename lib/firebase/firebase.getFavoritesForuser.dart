import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class GetFavouritesController extends GetxController {
  var isLoading = false.obs;
  final box = GetStorage();

  Future<QuerySnapshot> getuserFav() {
    return FirebaseFirestore.instance
        .collection('feedback')
        .where("email", isEqualTo: box.read('email'))
        .get();
  }

  void deleteFav(id) {
    FirebaseFirestore.instance.collection('feedback').doc(id).delete();
  }
}
