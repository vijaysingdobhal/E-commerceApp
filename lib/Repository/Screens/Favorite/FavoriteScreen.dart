import 'package:ecommerceapp/Api/FavoriteService.dart';
import 'package:ecommerceapp/Repository/Screens/ProductDetail/ProductDetailScreen.dart';
import 'package:flutter/material.dart';

import '../../../Domain/Constant/appcolor.dart';
import '../BottomNov/BottomNavScreen.dart';


class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final FavoriteService _favoriteService = FavoriteService();

  @override
  void initState() {
    super.initState();
    _favoriteService.addListener(_onFavoritesChanged);
  }

  @override
  void dispose() {
    _favoriteService.removeListener(_onFavoritesChanged);
    super.dispose();
  }

  void _onFavoritesChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final favorites = _favoriteService.favoriteItems;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Appcolor.textColor),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const BottomNavScreen()),
            );
          },
        ),
        title: const Text(
          'Favorites',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: favorites.isEmpty
          ? const Center(child: Text("No favorite products found"))
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final product = favorites[index];
                return _buildFavoriteItem(product);
              },
            ),
    );
  }

  Widget _buildFavoriteItem(dynamic product) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: Image.network(product['image'], width: 80, height: 80, fit: BoxFit.cover),
          title: Text(product['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text('\$${product['price']}', style: const TextStyle(color: Colors.grey)),
          trailing: IconButton(
            icon: const Icon(Icons.favorite, color: Colors.red),
            onPressed: () {
              _favoriteService.toggleFavorite(product);
            },
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailScreen(product: product),
              ),
            );
          },
        ),
      ),
    );
  }
}
