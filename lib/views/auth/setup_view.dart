import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_wallet/controllers/profile_setup_controller.dart';
import 'package:e_wallet/global_widgets/custom_app_bar.dart';
import 'package:e_wallet/global_widgets/custom_button.dart';
import 'package:e_wallet/global_widgets/custom_field.dart';
import 'package:e_wallet/views/nav_view/nav_view.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileSetupView extends StatelessWidget {
  final ProfileSetupController controller = Get.put(ProfileSetupController());
  final email = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: 'Complete Setup',
        hideLeading: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          GetBuilder<ProfileSetupController>(
                            builder: (_) => Column(
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
                                            backgroundImage: FileImage(File(
                                                controller.pickedImage!.path)),
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
                                CustomField(
                                  title: 'Your Full Name',
                                  controller: controller.nameController,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                CustomField(
                                  title: 'Your Phone Number',
                                  controller: controller.phoneController,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                CustomField(
                                  title: 'Your NID',
                                  controller: controller.nidController,
                                ),
                                const SizedBox(
                                  height:
                                      20, // Added space between the last field and the button
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      CustomButton(
                        title: 'Complete Setup',
                        onTap: () async {
                          final token = await FirebaseMessaging.instance.getToken();
                          try {
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(email)
                                .set({
                              'email': email,
                              'full_name': controller.nameController.text,
                              'phone': controller.phoneController.text,
                              'nid': controller.nidController.text,
                              'profile_picture':
                                  controller.downloadableUrl.value,
                              'balance': 0,
                              'token' : token ,
                            }).then((value) {
                              Get.offAll(() => const NavBarView());
                            });
                          } catch (e) {
                            print('Error saving data to Firestore: $e');
                          }
                        },
                        //onTap: () => Get.to(() => const NavBarView()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
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
