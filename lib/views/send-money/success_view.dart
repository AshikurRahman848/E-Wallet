import 'package:e_wallet/global_widgets/custom_button.dart';
import 'package:flutter/material.dart';

class SuccessView extends StatelessWidget {
  const SuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
          const Text(
            '\$500.50',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Text(
            'has been sent to friend@gmail.com from your wallet',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.black.withOpacity(.5),
              fontSize: 15,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const CustomButton(title: 'Done')
        ],
      )),
    );
  }
}
