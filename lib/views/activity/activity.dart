import 'package:e_wallet/global_widgets/custom_app_bar.dart';
import 'package:e_wallet/global_widgets/custom_list_tile.dart';
import 'package:flutter/material.dart';

class ActivityView extends StatelessWidget {
  const ActivityView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'Activity'),
      body: ListView.builder(
          itemCount: 30,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          itemBuilder: (context, index) {
            return const CustomListTile(
              title: 'Md. Bitto',
              subtitle: '3 Days Ago',
              trailing: '-600',
            );
          }),
    );
  }
}
