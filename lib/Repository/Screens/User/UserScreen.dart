import 'package:ecommerceapp/Api/UserService.dart';
import 'package:ecommerceapp/Model/User.dart';
import 'package:ecommerceapp/Repository/Screens/User/MyOrdersScreen.dart';
import 'package:ecommerceapp/Repository/Screens/User/SettingsScreen.dart';
import 'package:ecommerceapp/Repository/Screens/login/LoginScreen.dart';
import 'package:flutter/material.dart';

import '../BottomNov/BottomNavScreen.dart';

class UserScreen extends StatelessWidget {
  final UserService _userService = UserService();

  UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User user = _userService.getMockUser();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const BottomNavScreen()),
            );
          },
        ),
        title: const Text('My Profile', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(user.avatarUrl),
            ),
            const SizedBox(height: 16),
            Text(
              user.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            const SizedBox(height: 8),
            Text(
              user.email,
              style: const TextStyle(color: Colors.grey, fontSize: 16),
            ),
            const SizedBox(height: 32),
            _buildProfileOption(Icons.list_alt, 'My Orders', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyOrdersScreen()),
              );
            }),
            _buildProfileOption(Icons.settings, 'Settings', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            }),
            _buildProfileOption(Icons.logout, 'Logout', () {
              _showLogoutConfirmationDialog(context);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Logout'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }
}
