
import 'package:ecommerceapp/Api/UserService.dart';
import 'package:ecommerceapp/Model/User.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  final UserService _userService = UserService();

  UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User user = _userService.getMockUser();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
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
            _buildProfileOption(Icons.list_alt, 'My Orders', () {}),
            _buildProfileOption(Icons.settings, 'Settings', () {}),
            _buildProfileOption(Icons.logout, 'Logout', () {}),
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
}
