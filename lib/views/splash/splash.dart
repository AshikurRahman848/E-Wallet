import 'dart:async';
import 'package:e_wallet/views/auth/login.dart';
import 'package:e_wallet/views/nav_view/nav_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<User?> checkUser() async {
    // Handle any asynchronous user check logic here (if needed)
    return FirebaseAuth.instance.currentUser;
  }

  @override
  void initState() {
    super.initState();
    Future<User?> userFuture = checkUser(); // Separate function for user check

    Timer(const Duration(seconds: 3), () async {
      User? user = await userFuture; // Wait for the user check to complete
      if (user == null) {
        Get.offAll(() => const LoginView());
      } else {
        Get.offAll(() => const NavBarView());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/PayPal.png',
          width: 150,
        ),
      ),
    );
  }
}
