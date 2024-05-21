import 'package:e_wallet/global_widgets/custom_app_bar.dart';
import 'package:e_wallet/global_widgets/custom_button.dart';
import 'package:e_wallet/global_widgets/custom_field.dart';
import 'package:e_wallet/views/send-money/amount_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReciverView extends StatelessWidget {
  const ReciverView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: 'Send Money',
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CustomField(
              title: 'Enter Receiver Email Address',
            ),
            const SizedBox(height: 20),
            CustomButton(
              title: 'Send',
              onTap: () => Get.to(() => const AmountView()),
            ),
          ],
        ),
      ),
    );
  }
}
