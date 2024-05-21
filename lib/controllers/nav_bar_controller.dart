import 'package:e_wallet/views/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavBarController extends GetxController {
  var currentIndex = 0.obs;
List <Widget> screens =[
  const HomeView(),
  const Center(
    child: Text('Contacts'),
  ),
  const Center(
    child: Text('Wallets'),
  ),
  const Center(
    child: Text('Settings'),
  ),
];
  void changeIndex(int index) {
    currentIndex.value = index;
  }
}
