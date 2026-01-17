import 'package:ecommerceapp/Repository/Screens/Home/HomeScreen.dart';
import 'package:flutter/material.dart';
import '../Card/CartScreen.dart';
import '../Favorite/FavoriteScreen.dart';
import '../User/UserScreen.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const CartScreen(),
    const FavoriteScreen(),
    UserScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xffF87217);

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        elevation: 0,
        backgroundColor: Colors.transparent,
        items: [
          BottomNavigationBarItem(
            icon: _BottomNavIcon(
              iconData: Icons.home,
              isSelected: _currentIndex == 0,
              color: _currentIndex == 0 ? primaryColor : Colors.grey,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _BottomNavIcon(
              iconData: Icons.shopping_cart_outlined,
              isSelected: _currentIndex == 1,
              color: _currentIndex == 1 ? primaryColor : Colors.grey,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _BottomNavIcon(
              iconData: Icons.favorite_border,
              isSelected: _currentIndex == 2,
              color: _currentIndex == 2 ? primaryColor : Colors.grey,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _BottomNavIcon(
              iconData: Icons.person_outline,
              isSelected: _currentIndex == 3,
              color: _currentIndex == 3 ? primaryColor : Colors.grey,
            ),
            label: '',
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class _BottomNavIcon extends StatelessWidget {
  final IconData iconData;
  final bool isSelected;
  final Color color;

  const _BottomNavIcon({
    required this.iconData,
    required this.isSelected,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          iconData,
          color: color,
          size: 30.0,
        ),
        const SizedBox(height: 4),
        if (isSelected)
          Container(
            height: 5,
            width: 5,
            decoration: const BoxDecoration(
              color: Color(0xffF87217),
              shape: BoxShape.circle,
            ),
          )
        else
          const SizedBox(height: 5),
      ],
    );
  }
}
