import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecommerceapp/Api/CartService.dart';
import 'package:ecommerceapp/Api/FavoriteService.dart';

final cartServiceProvider = Provider<CartService>((ref) {
  return CartService();
});

// Provider for FavoriteService
final favoriteServiceProvider = Provider<FavoriteService>((ref) {
  return FavoriteService();
});

// If your init() methods are async, you can use a FutureProvider
final favoriteServiceFutureProvider = FutureProvider<FavoriteService>((ref) async {
  final favoriteService = FavoriteService();
  await favoriteService.init();
  return favoriteService;
});

final cartServiceFutureProvider = FutureProvider<CartService>((ref) async {
  final cartService = CartService();
  await cartService.init();
  return cartService;
});
