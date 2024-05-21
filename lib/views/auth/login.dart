
import 'package:e_wallet/global_widgets/custom_button.dart';
import 'package:e_wallet/global_widgets/custom_field.dart';
//import 'package:e_wallet/views/home/home_view.dart';
import 'package:e_wallet/views/nav_view/nav_view.dart';
import 'package:flutter/material.dart';
import 'package:e_wallet/views/auth/signup.dart';
import 'package:get/get.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  const CustomField(
                    title: 'Enter your Email',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const CustomField(
                    title: 'Enter Password',secured: true,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomButton(
                    title: 'Log In',
                    onTap: () => Get.to(() => const NavBarView()),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'Having trouble loggin?',
                    style: TextStyle(color: Colors.black.withOpacity(.5)),
                  ),
                  TextButton(onPressed: () {
                    Get.to(()=> const SingupView());
                  }, child: const Text('Sign Up'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
