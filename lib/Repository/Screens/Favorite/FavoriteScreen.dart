import 'package:ecommerceapp/Api/FavoriteService.dart';
import 'package:ecommerceapp/Repository/Screens/ProductDetail/ProductDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Domain/Constant/appcolor.dart';
import '../BottomNov/BottomNavScreen.dart';

class FavoriteScreen extends ConsumerWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteAsyncValue = ref.watch(favoriteFutureProvider);

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
      body: favoriteAsyncValue.when(
        data: (_) {
          final favorites = ref.watch(favoriteServiceProvider);
          final favoriteNotifier = ref.read(favoriteServiceProvider.notifier);

          if (favorites.isEmpty) {
            return const Center(child: Text("No favorite products found"));
          }

          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final product = favorites[index];
              return _buildFavoriteItem(context, product, favoriteNotifier);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text("Error: $err")),
      ),
    );
  }

  Widget _buildFavoriteItem(
      BuildContext context, dynamic product, FavoriteService favoriteNotifier) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: Image.network(product['image'],
              width: 80, height: 80, fit: BoxFit.cover),
          title: Text(product['title'],
              style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text('\$${product['price']}',
              style: const TextStyle(color: Colors.grey)),
          trailing: IconButton(
            icon: const Icon(Icons.favorite, color: Colors.red),
            onPressed: () {
              favoriteNotifier.toggleFavorite(product);
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
