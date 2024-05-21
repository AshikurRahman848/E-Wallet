import 'package:e_wallet/global_widgets/custom_app_bar.dart';
import 'package:e_wallet/global_widgets/custom_button.dart';
import 'package:e_wallet/global_widgets/custom_field.dart';
import 'package:e_wallet/views/send-money/success_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AmountView extends StatelessWidget {
  const AmountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'Send Money'),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey.withOpacity(.2),
                  ),
                  title: Text(
                    'To',
                    style: TextStyle(color: Colors.black.withOpacity(.5)),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Md.Fajlur Rahman',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'ashikurbitto@gmail.com',
                        style: TextStyle(color: Colors.black.withOpacity(.5)),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const CustomField(
                  title: 'Enter Amount',
                  prefixIcon: Icons.attach_money_outlined,
                  keyboardType: TextInputType.phone,
                )
              ],
            ),
            CustomButton(
              title: 'Send',
              onTap: () => Get.offAll(() => const SuccessView()),
            )
          ],
        ),
      ),
    );
  }
}
