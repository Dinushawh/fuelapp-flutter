import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';

class UpdateProfile extends GetxController {
  var isLoading = false.obs;
  final box = GetStorage();

  Future<void> updateUserData(
    String profilePicture,
    String firstName,
    String lastName,
    String email,
    Function(String) callback,
  ) async {
    try {
      final DocumentReference userRef =
          FirebaseFirestore.instance.collection('users').doc(box.read('docId'));

      final Map<String, dynamic> updateData = {};

      if (profilePicture.isNotEmpty) {
        updateData['profilePicture'] = profilePicture;
      }
      if (firstName.isNotEmpty) {
        updateData['firstName'] = firstName;
      }
      if (lastName.isNotEmpty) {
        updateData['lastName'] = lastName;
      }
      if (email.isNotEmpty) {
        updateData['email'] = email;
      }

      if (updateData.isNotEmpty) {
        await userRef.update(updateData);
        return callback('success');
      }
    } catch (e) {
      debugPrint('Error updating user data: $e');
      return callback('error');
    }
  }
}
