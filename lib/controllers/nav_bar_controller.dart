import 'package:e_wallet/views/auth/login.dart';
import 'package:e_wallet/views/home/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavBarController extends GetxController {
  var currentIndex = 0.obs;
  List<Widget> screens = [
    const HomeView(),
    const Center(
      child: Text('Contacts'),
    ),
    const Center(
      child: Text('Wallets'),
    ),
    Center(child: ElevatedButton(onPressed: () {
      FirebaseAuth.instance.signOut();
      Get.offAll(()=> const LoginView());
    }, child: const Text('log out'))),
  ];
  void changeIndex(int index) {
    currentIndex.value = index;
    update();
  }
}
