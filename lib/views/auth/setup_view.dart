import 'dart:io';

import 'package:e_wallet/controllers/profile_setup_controller.dart';
import 'package:e_wallet/global_widgets/custom_app_bar.dart';
import 'package:e_wallet/global_widgets/custom_button.dart';
import 'package:e_wallet/global_widgets/custom_field.dart';
import 'package:e_wallet/views/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:image_picker/image_picker.dart';

class ProfileSetupView extends StatelessWidget {
  final ProfileSetupController controller = Get.put(ProfileSetupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: 'Complete Setup',
        hideLeading: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: GetBuilder<ProfileSetupController>(
            builder: (_) => Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        controller.pickedImage == null
                            ? const CircleAvatar(
                                radius: 60,
                                child: Icon(Icons.person, size: 60),
                              )
                            : CircleAvatar(
                                radius: 60,
                                backgroundImage:
                                    FileImage(File(controller.pickedImage!.path)),
                              ),
                        InkWell(
                          onTap: () => _showImageOptions(context),
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const CustomField(title: 'Your Full Name'),
                    const SizedBox(
                      height: 20,
                    ),
                    const CustomField(title: 'Your Phone Number'),
                    const SizedBox(
                      height: 20,
                    ),
                    const CustomField(title: 'Your NID'),
                  ],
                ),
                CustomButton(
                  title: 'Complete Setup',
                  onTap: () => Get.to(() => const HomeView()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showImageOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Pick from Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  controller.imagePicker(fromCamera: false);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take a Photo'),
                onTap: () {
                  Navigator.of(context).pop();
                  controller.imagePicker(fromCamera: true);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
