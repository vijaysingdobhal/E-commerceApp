import 'package:flutter/material.dart';

import '../../../Domain/Constant/appcolor.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Appcolor.textColor),
        centerTitle: true,
        backgroundColor: Appcolor.scaffoldbackgrount,
        elevation: 1,
        title: const Text(
          'My Orders',
          style: TextStyle(color: Appcolor.textColor),
        ),
      ),
      body: const Center(child: Text('My Orders Screen')),
    );
  }
}
