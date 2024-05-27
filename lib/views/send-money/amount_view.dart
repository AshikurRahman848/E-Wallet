import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_wallet/global_widgets/custom_app_bar.dart';
import 'package:e_wallet/global_widgets/custom_button.dart';
import 'package:e_wallet/global_widgets/custom_field.dart';
import 'package:e_wallet/views/send-money/success_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AmountView extends StatefulWidget {
  final Map<String, dynamic> receiverDetails;
  final Map<String, dynamic> senderDetails;

  const AmountView(
      {super.key, required this.receiverDetails, required this.senderDetails});

  @override
  _AmountViewState createState() => _AmountViewState();
}

class _AmountViewState extends State<AmountView> {
  final TextEditingController _amountController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> transferMoney() async {
    final int amount = int.parse(_amountController.text);

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Start a Firestore transaction
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        // Get references to the sender and receiver documents
        DocumentReference senderRef = FirebaseFirestore.instance
            .collection('users')
            .doc(widget.senderDetails['email']);
        DocumentReference receiverRef = FirebaseFirestore.instance
            .collection('users')
            .doc(widget.receiverDetails['email']);

        // Get the latest data of sender and receiver
        DocumentSnapshot senderSnapshot = await transaction.get(senderRef);
        DocumentSnapshot receiverSnapshot = await transaction.get(receiverRef);

        // Check sender's balance
        if (senderSnapshot['balance'] < amount) {
          throw Exception('Insufficient balance');
        }

        // Update sender's balance
        transaction.update(senderRef, {
          'balance': senderSnapshot['balance'] - amount,
        });

        // Update receiver's balance
        transaction.update(receiverRef, {
          'balance': receiverSnapshot['balance'] + amount,
        });
      });

      // Create transaction history
      transactionHistory(amount);

      // Navigate to success view
      Get.offAll(() => SuccessView(
            amount: _amountController.text,
            email: widget.receiverDetails['email'],
          ));
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  void transactionHistory(int amount) {
    FirebaseFirestore.instance.collection('history').add({
      'sender': widget.senderDetails['full_name'],
      'receiver': widget.receiverDetails['full_name'],
      'amount': amount,
      'time': DateTime.now(),
      'type': 'send',
      'sender_email': widget.senderDetails['email'],
      'receiver_email': widget.receiverDetails['email'],
    });
  }

  void _sendMoney() {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    double? amount = double.tryParse(_amountController.text);

    if (amount == null) {
      setState(() {
        _errorMessage = 'Please enter a valid amount';
        _isLoading = false;
      });
      return;
    }

    if (amount > widget.senderDetails['balance']) {
      setState(() {
        _errorMessage = 'Insufficient balance';
        _isLoading = false;
      });
      return;
    }

    transferMoney();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'Send Money'),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey.withOpacity(.2),
                    backgroundImage:
                        NetworkImage(widget.receiverDetails['profile_picture']),
                  ),
                  title: Text(
                    'To',
                    style: TextStyle(color: Colors.black.withOpacity(.5)),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.receiverDetails['full_name'],
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.receiverDetails['email'],
                        style: TextStyle(color: Colors.black.withOpacity(.5)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomField(
                  controller: _amountController,
                  title: 'Enter Amount',
                  prefixIcon: Icons.attach_money_outlined,
                  keyboardType: TextInputType.number,
                ),
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Available Balance \$${widget.senderDetails['balance']}',
                  style: TextStyle(color: Colors.black.withOpacity(.5)),
                ),
              ],
            ),
            CustomButton(
              title: 'Send',
              onTap: _isLoading ? null : _sendMoney,
            ),
            if (_isLoading)
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
