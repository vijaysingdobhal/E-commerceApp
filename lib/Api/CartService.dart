import 'dart:convert';
import 'package:ecommerceapp/Model/CartItem.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartService extends Notifier<List<CartItem>> {
  static const String _cartKey = 'cartItems';

  Future<void> init() async {
    await _loadCart();
  }

  @override
  List<CartItem> build() {
    return [];
  }

  Future<void> _loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? cartJson = prefs.getStringList(_cartKey);
    if (cartJson != null) {
      state = cartJson.map((item) => CartItem.fromJson(json.decode(item))).toList();
    } else {
      state = [];
    }
  }

  Future<void> _saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> cartJson = state.map((item) => json.encode(item.toJson())).toList();
    await prefs.setStringList(_cartKey, cartJson);
  }

  void addToCart(dynamic product) {
    final int quantityToAdd = product['quantity'] as int? ?? 1;
    final existingItemIndex = state.indexWhere((item) => item.product['id'] == product['id']);

    if (existingItemIndex != -1) {
      final updatedList = List<CartItem>.from(state);
      final existingItem = updatedList[existingItemIndex];
      updatedList[existingItemIndex] = CartItem(
        product: existingItem.product,
        quantity: existingItem.quantity + quantityToAdd,
      );
      state = updatedList;
    } else {
      state = [...state, CartItem(product: product, quantity: quantityToAdd)];
    }
    _saveCart();
  }

  void removeFromCart(CartItem cartItem) {
    state = state.where((item) => item.product['id'] != cartItem.product['id']).toList();
    _saveCart();
  }

  void increaseQuantity(CartItem cartItem) {
    state = [
      for (final item in state)
        if (item.product['id'] == cartItem.product['id'])
          CartItem(product: item.product, quantity: item.quantity + 1)
        else
          item
    ];
    _saveCart();
  }

  void decreaseQuantity(CartItem cartItem) {
    final currentItem = state.firstWhere((item) => item.product['id'] == cartItem.product['id']);
    if (currentItem.quantity > 1) {
      state = [
        for (final item in state)
          if (item.product['id'] == cartItem.product['id'])
            CartItem(product: item.product, quantity: item.quantity - 1)
          else
            item
      ];
    } else {
      removeFromCart(cartItem);
    }
    _saveCart();
  }

  double getTotalPrice() {
    double total = 0;
    for (var item in state) {
      final price = item.product['price'];
      if (price is num) {
        total += price * item.quantity;
      }
    }
    return total;
  }
}

final cartServiceProvider = NotifierProvider<CartService, List<CartItem>>(CartService.new);

final cartFutureProvider = FutureProvider<void>((ref) async {
  await ref.read(cartServiceProvider.notifier).init();
});

final cartTotalProvider = Provider<double>((ref) {
  final cart = ref.watch(cartServiceProvider);
  double total = 0;
  for (var item in cart) {
    final price = item.product['price'];
    if (price is num) {
      total += price * item.quantity;
    }
  }
  return total;
});
