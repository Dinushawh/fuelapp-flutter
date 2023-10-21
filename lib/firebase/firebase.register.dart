// ignore_for_file: camel_case_types, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class userRegister extends GetxController {
  var isLoading = false.obs;

  void registerAccount(
    String email,
    String firstname,
    String lname,
    String pwd,
    Function(String) callback,
  ) async {
    try {
      // print(email);
      // print(firstname);
      // print(lname);

      isLoading(true);
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pwd,
      );
      await FirebaseFirestore.instance.collection('users').add({
        'email': email,
        'firstname': firstname,
        'lastname': lname,
        'profilePicture': 'http://via.placeholder.com/350x150',
        'points': 0,
        'date created': DateTime.now(),
      });
      callback('success');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        callback('weak-password');
      } else if (e.code == 'email-already-in-use') {
        callback('email-already-in-use');
      }
    } catch (e) {
      print(e.toString());
      callback('error');
    } finally {
      isLoading(false);
    }
  }
}
