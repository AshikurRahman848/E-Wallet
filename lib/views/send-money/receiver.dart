import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_wallet/global_widgets/custom_app_bar.dart';
import 'package:e_wallet/global_widgets/custom_button.dart';
import 'package:e_wallet/global_widgets/custom_field.dart';
import 'package:e_wallet/views/send-money/amount_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReciverView extends StatelessWidget {
  const ReciverView({super.key});

  @override
  Widget build(BuildContext context) {
    final receiverEmailController = TextEditingController();
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: customAppBar(
        title: 'Send Money',
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomField(
              title: 'Enter Receiver Email Address',
              controller: receiverEmailController,
            ),
            const SizedBox(height: 20),
            CustomButton(
                title: 'Send',
                onTap: () async {
                  final receiver = await FirebaseFirestore.instance
                      .collection('users')
                      .doc(receiverEmailController.text)
                      .get();
                      final sender = await FirebaseFirestore.instance
                      .collection('users')
                      .doc(user!.email)
                      .get();
                  final receiverData = receiver.data();
                  if (receiverData == null) {
                    Get.snackbar('User not exits',
                        'The user ${receiverEmailController.text} not exists');
                  } else {
                    // user exists
                    if (receiverData['email'] == user.email) {
                      Get.snackbar('Error', 'You can\'t sent to yourself');
                    } else {
                      Get.to(() =>  AmountView(
                        receiverDetails: receiverData,
                        senderDetails: sender.data()!,
                      ),
                      );
                    }
                  }
                }),
          ],
        ),
      ),
    );
  }
}
