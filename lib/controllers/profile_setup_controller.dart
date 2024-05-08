import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileSetupController extends GetxController {
  File? pickedImage;

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
    } catch (e) {
      print('Error is ${e.toString()}');
    }
  }
}
