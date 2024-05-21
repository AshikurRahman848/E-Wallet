import 'package:e_wallet/controllers/nav_bar_controller.dart';
import 'package:e_wallet/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavBarView extends StatelessWidget {
  const NavBarView({super.key});

  @override
  Widget build(BuildContext context) {
    final NavBarController controller = Get.put(NavBarController());

    return Obx(
      () => Scaffold(
        body: controller.screens[controller.currentIndex.value],
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            selectedItemColor: AppColors.primary,
            unselectedItemColor: Colors.black,
            currentIndex: controller.currentIndex.value,
            onTap: (index) => controller.changeIndex(index),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.group), label: 'Contracts'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.wallet), label: 'Wallet'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Settings'),
            ],
          ),
        ),
      ),
    );
  }
}
