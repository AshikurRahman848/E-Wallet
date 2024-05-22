import 'package:e_wallet/global_widgets/custom_home_item.dart';
import 'package:e_wallet/global_widgets/custom_list_tile.dart';
import 'package:e_wallet/utils/colors.dart';
import 'package:e_wallet/views/activity/activity.dart';
import 'package:e_wallet/views/send-money/receiver.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: size.height * 0.32,
              width: size.width,
              decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(40))),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/images/favicon.png',
                          height: 60,
                        ),
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Colors.white.withOpacity(.1),
                                width: 4,
                              ),
                              image: const DecorationImage(
                                  image: NetworkImage(
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQGTFQJsNvORDziLimBrg9ECLThvjAb9pEtTQ&s'),
                                  fit: BoxFit.cover)),
                        )
                      ],
                    ),
                    Text(
                      'Hello, Ashik!',
                      style: TextStyle(
                          color: Colors.white.withOpacity(.8), fontSize: 18),
                    ),
                    Column(
                      children: [
                        Text(
                          '\$ 550.00',
                          style: TextStyle(
                            color: Colors.white.withOpacity(.8),
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'Your Balance',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CustomHomeItem(
                            title: 'Send\nMoney',
                            icon: Icons.send,
                            onTap: () => Get.to(() => const ReciverView()),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          const CustomHomeItem(
                            icon: Icons.monetization_on,
                            title: 'Add\nMoney',
                            backgroundColor: Colors.white,
                            itemColor: Colors.black,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Activity'),
                          InkWell(
                            onTap: () => Get.to(() => const ActivityView()),
                            child: const Text('See All'),
                          ),
                        ],
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return const CustomListTile(
                              title: 'Md.Ashikur Rahman',
                              subtitle: '4 Days ago',
                              trailing: '-600',
                            );
                          })
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
