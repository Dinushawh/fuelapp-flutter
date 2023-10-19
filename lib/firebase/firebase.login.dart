// ignore_for_file: avoid_print, camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class userLogin extends GetxController {
  var isLoading = false.obs;

  void loginAccount(
    String email,
    String password,
    Function(String) callback,
  ) async {
    final box = GetStorage();
    try {
      isLoading(true);
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      callback('success');
      try {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: email)
            .get()
            .then((value) => value);

        if (querySnapshot.docs.isNotEmpty) {
          for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
            print('Data for email $email: ${documentSnapshot.data()}');
            box.write('docId', documentSnapshot.id);
            box.write('fname', documentSnapshot.get('firstname'));
            box.write('email', documentSnapshot.get('email'));
            box.write('lanme', documentSnapshot.get('lastname'));
            box.write('profilePicture', documentSnapshot.get('profilePicture'));
          }
        } else {
          print('No data found for email $email');
        }
      } catch (e) {
        print('Error fetching data: $e');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        callback('user-not-found');
      } else if (e.code == 'wrong-password') {
        callback('wrong-password');
      }
    } catch (e) {
      callback('error');
    } finally {
      isLoading(false);
    }
  }
}
