import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_wallet/global_widgets/custom_home_item.dart';
import 'package:e_wallet/global_widgets/custom_list_tile.dart';
import 'package:e_wallet/utils/colors.dart';
import 'package:e_wallet/views/activity/activity.dart';
import 'package:e_wallet/views/send-money/receiver.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final user = FirebaseAuth.instance.currentUser;
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
                  child: StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(user!.email)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        }
                        if (!snapshot.hasData || !snapshot.data!.exists) {
                          return const Center(
                              child: Text('User data not found'));
                        }
                        final userData =
                            snapshot.data!.data() as Map<String, dynamic>;
                        return Column(
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
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              userData['profile_picture']),
                                          fit: BoxFit.cover)),
                                )
                              ],
                            ),
                            Text(
                              'Hello, ${userData['full_name']}!',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(.8),
                                  fontSize: 18),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '\$ ${userData['balance']}',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(.8),
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Text(
                                  'Your Balance',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ],
                            )
                          ],
                        );
                      })),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        child: Row(
                          children: [
                            CustomHomeItem(
                              title: 'Send\nMoney',
                              icon: Icons.send,
                              onTap: () => Get.to(() => const ReciverView()),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            CustomHomeItem(
                              icon: Icons.monetization_on,
                              title: 'Add\nMoney',
                              backgroundColor: Colors.white,
                              itemColor: Colors.black,
                              onTap: () async {
                                print(await FirebaseMessaging.instance
                                    .getToken());
                              },
                            ),
                          ],
                        ),
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
                      StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('history')
                              .orderBy('time',
                                  descending:
                                      true) // Order by the 'time' field in descending order
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              ); // Center
                            } else {
                              return ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                primary: false,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  final data = snapshot.data!.docs[index];
                                  bool isMe =
                                      data['sender_email'] == user.email;
                                  bool ifIAmReceiver =
                                      data['receiver_email'] == user.email;
                                  DateTime trxTime =
                                      (data['time'] as Timestamp).toDate();

                                  final formateddate =
                                      DateFormat.yMMMd().format(trxTime);
                                  final formatedTime =
                                      DateFormat.jm().format(trxTime);

                                  String amountString =
                                      '${data['amount']}'; // Convert amount to string

                                  return isMe || ifIAmReceiver
                                      ? CustomListTile(
                                          title: isMe
                                              ? data['receiver']
                                              : data['sender'],
                                          subtitle:
                                              '$formateddate - $formatedTime',
                                          trailing: isMe
                                              ? '-\$$amountString'
                                              : '+\$$amountString', // Add $ before and after the amount
                                          trailingTextStyle: const TextStyle(
                                              color: Colors.black),
                                        )
                                      : const SizedBox();
                                },
                              ); // ListView.builder
                            }
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
