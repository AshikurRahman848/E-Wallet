import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileSetupController extends GetxController {
  File? pickedImage;
  RxString downloadableUrl = RxString('');

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final nidController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> imagePicker({required bool fromCamera}) async {
    try {
      final ImageSource source =
          fromCamera ? ImageSource.camera : ImageSource.gallery;
      final image = await ImagePicker().pickImage(source: source);

      if (image == null) return;

      print('temp ${image.path}');
      final tempImage = File(image.path);

      pickedImage = tempImage;
      update();
      print(pickedImage!.path);

      final storageRef = FirebaseStorage.instance
          .ref()
          .child('${DateTime.now().microsecondsSinceEpoch}_profile_picture');

      UploadTask uploadTask = storageRef.putFile(tempImage);
      TaskSnapshot taskSnapshot = await uploadTask;

      if (taskSnapshot.state == TaskState.success) {
        downloadableUrl.value = await storageRef.getDownloadURL();
        update();
        print('image url ${downloadableUrl.value}');

        // Save the downloadable URL to Firestore
        await _saveImageUrlToFirestore(downloadableUrl.value);
      } else {
        print('Error during file upload: ${taskSnapshot.state}');
      }
    } catch (e) {
      print('Error is ${e.toString()}');
    }
  }

  Future<void> _saveImageUrlToFirestore(String url) async {
    try {
      String userId = 'some_user_id'; // Replace with the actual user ID
      await _firestore.collection('users').doc(userId).update({
        'profile_picture': url,
      });
      print('Profile picture URL updated in Firestore');
    } catch (e) {
      print('Failed to update Firestore: ${e.toString()}');
    }
  }
}
