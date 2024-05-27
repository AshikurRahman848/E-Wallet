import 'package:e_wallet/global_widgets/custom_app_bar.dart';
import 'package:e_wallet/global_widgets/custom_button.dart';
import 'package:e_wallet/global_widgets/custom_field.dart';
import 'package:e_wallet/views/auth/setup_view.dart';

import 'package:firebase_auth/firebase_auth.dart';
//import 'package:e_wallet/views/auth/setup_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SingupView extends StatefulWidget {
  const SingupView({super.key});

  @override
  State<SingupView> createState() => _SingupView();
}

class _SingupView extends State<SingupView> {
  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    return Scaffold(
      appBar: customAppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                'assets/images/PayPal.png',
                width: 200,
              ),
              Column(
                children: [
                  CustomField(
                    title: 'Enter your Email',
                    controller: emailController,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomField(
                    title: 'Enter Password',
                    secured: true,
                    controller: passwordController,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomButton(
                    title: 'Sign Up',
                    onTap: () async {
                      try {
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text);
                        Get.offAll(() => ProfileSetupView(),
                        arguments: emailController.text);
                      } on FirebaseAuthException catch (error) {
                        print(error);
                      }
                    },
                    //onTap: ()=> Get.to(()=>  ProfileSetupView()),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(color: Colors.black.withOpacity(.5)),
                  ),
                  TextButton(
                      onPressed: () => Get.back(), child: const Text('Log In'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
