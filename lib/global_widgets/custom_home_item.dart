import 'package:e_wallet/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomHomeItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color? backgroundColor;
  final Color? itemColor;
  final void Function()? onTap;
  const CustomHomeItem(
      {super.key,
      required this.icon,
      required this.title,
      this.backgroundColor,
      this.onTap,
      this.itemColor});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 130,
        width: size.width * .35,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: backgroundColor?? AppColors.primary,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.3),
              blurRadius: 8,
            )
          ]
        ),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
             Icon(
              icon,
              color:itemColor ?? Colors.white,
            ),
            Text(
              title,
              style:  TextStyle(
                color:itemColor?? Colors.white
                ),
            )
          ],
        ),
      ),
    );
  }
}
