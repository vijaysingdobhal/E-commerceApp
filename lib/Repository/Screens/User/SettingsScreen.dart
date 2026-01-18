import 'package:flutter/material.dart';

import '../../../Domain/Constant/appcolor.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Appcolor.textColor),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Appcolor.scaffoldbackgrount,
        title: const Text(
          'Settings',
          style: TextStyle(color: Appcolor.textColor),
        ),
      ),
      body: const Center(child: Text('Settings Screen')),
    );
  }
}
