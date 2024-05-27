import 'package:e_wallet/global_widgets/custom_button.dart';
import 'package:e_wallet/views/nav_view/nav_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessView extends StatelessWidget {
  final String amount;
  final String email;
  const SuccessView({super.key, required this.amount, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 60,
            ),
            const Text(
              'Success!',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 30,
              ),
            ),
            Text(
              '\$$amount',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              'has been sent to $email from your wallet',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.black.withOpacity(.5),
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            CustomButton(
              title: 'Done',
              onTap: () => Get.offAll(const NavBarView()),
            )
          ],
        ),
      )),
    );
  }
}
