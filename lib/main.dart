import 'package:ecommerceapp/Api/CartService.dart';
import 'package:ecommerceapp/Api/FavoriteService.dart';
import 'package:flutter/material.dart';

import 'Domain/Constant/appcolor.dart';
import 'Repository/Screens/Splash/SplashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CartService().init();
  await FavoriteService().init();
  runApp(const MyApp());
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
