import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AddFeedback extends GetxController {
  var isLoading = false.obs;
  final box = GetStorage();

  Future<void> addFeedback(
    String fuelstation,
    String name,
    double rate,
    String comment,
    Function(String) callback,
  ) async {
    isLoading(true);

    try {
      await FirebaseFirestore.instance.collection('feedback').add({
        'fuelstation': fuelstation,
        'email': box.read('email'),
        'image': box.read('profilePicture'),
        'name': name,
        'rating': rate,
        'comment': comment,
        "points": 100,
        'dateCreated': DateTime.now(),
      });
      callback('success');
    } catch (e) {
      callback('error');
    } finally {
      isLoading(false);
    }
  }
}
