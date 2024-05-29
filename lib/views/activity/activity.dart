import 'package:e_wallet/global_widgets/custom_app_bar.dart';
import 'package:e_wallet/global_widgets/custom_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class ActivityView extends StatelessWidget {
  const ActivityView({Key? key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // Handle if user is not logged in
      return Scaffold(
        appBar: AppBar(
          title: const Text('Activity'),
        ),
        body: const Center(
          child: Text('User not logged in'),
        ),
      );
    }

    return Scaffold(
      appBar: customAppBar(title: 'Activity'),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('history')
            .orderBy('time',
                descending: true) // Order by time in descending order
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              shrinkWrap: true,
              primary: false,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final data = snapshot.data!.docs[index];
                bool isMe = data['sender_email'] == user.email;
                bool ifIAmReceiver = data['receiver_email'] == user.email;
                DateTime trxTime = (data['time'] as Timestamp).toDate();

                final formateddate = DateFormat.yMMMd().format(trxTime);
                final formatedTime = DateFormat.jm().format(trxTime);
                String amount = '${data['amount']}'; // Convert amount to string

                return isMe || ifIAmReceiver
                    ? CustomListTile(
                        title: isMe ? data['receiver'] : data['sender'],
                        subtitle: '$formateddate - $formatedTime',
                        trailing: isMe
                            ? '-\$$amount' // Add $ before amount for sender
                            : '+\$$amount', // Add $ before amount for receiver
                        trailingTextStyle: const TextStyle(
                          color: Colors.black,
                        ),
                      )
                    : const SizedBox();
              },
            );
          }
        },
      ),
    );
  }
}
