
import 'package:e_wallet/global_widgets/custom_button.dart';
import 'package:e_wallet/global_widgets/custom_field.dart';
//import 'package:e_wallet/views/home/home_view.dart';
import 'package:e_wallet/views/nav_view/nav_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
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
                   CustomField(
                    title: 'Enter your Email',
                    controller: emailController,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                   CustomField(
                    title: 'Enter Password',secured: true,
                    controller: passwordController,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomButton(
                    title: 'Log In',
                    onTap: () async{
                       try {
                         await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: emailController.text, 
                        password: passwordController.text
                        );
                        Get.offAll(()=> const NavBarView());
                       }on FirebaseAuthException catch(error){
                        print (error);
                        Get.snackbar('Error', error.message!);
                       }
                      },
                   // onTap: () => Get.to(() => const NavBarView()),
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
