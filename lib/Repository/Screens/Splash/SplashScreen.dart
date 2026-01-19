import 'package:ecommerceapp/counter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../Domain/Constant/appcolor.dart';
import '../login/LoginScreen.dart';
import 'dart:async';
import 'package:lottie/lottie.dart';

class SplashScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);

    // Navigate after the animation duration
    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });

    return Scaffold(
      backgroundColor: Appcolor.scaffoldbackgrount,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'Assets/Images/cart_animation.json', // Your animation file path
              width: 250,
              height: 250,
              fit: BoxFit.fill,
            ),
            SizedBox(height: 20),
            Text(
              'E-Commerce App',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Appcolor.primaryColor, // Use a color from your theme
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Counter: $counter',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Appcolor.primaryColor, // Use a color from your theme
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(counterProvider.notifier).state++,
        child: Icon(Icons.add),
      ),
    );
  }
}
