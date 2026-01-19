import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'Domain/Constant/appcolor.dart';
import 'Repository/Screens/Splash/SplashScreen.dart';

void main() async {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-APP',
      theme: ThemeData(
        primaryColor: Appcolor.primaryColor,
        colorScheme: ColorScheme.fromSeed(seedColor: Appcolor.primaryColor),
        scaffoldBackgroundColor: Appcolor.scaffoldbackgrount,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Appcolor.textColor),
          bodyMedium: TextStyle(color: Appcolor.secondaryTextColor),
        ),
        useMaterial3: false,
      ),
      home: SplashScreen(),
    );
  }
}
