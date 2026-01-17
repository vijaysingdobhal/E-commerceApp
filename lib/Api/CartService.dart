import 'package:ecommerceapp/Model/CartItem.dart';
import 'package:flutter/material.dart';

class CartService {
  static final CartService _instance = CartService._internal();

  factory CartService() {
    return _instance;
  }

  CartService._internal();

  final List<CartItem> _cartItems = [];
  final List<VoidCallback> _listeners = [];

  List<CartItem> get cartItems => _cartItems;

  void addListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  void removeListener(VoidCallback listener) {
    _listeners.remove(listener);
  }

  void notifyListeners() {
    for (var listener in _listeners) {
      listener();
    }
  }

  void addToCart(dynamic product) {
    final int quantityToAdd = product['quantity'] as int? ?? 1;
    for (var item in _cartItems) {
      if (item.product['id'] == product['id']) {
        item.quantity += quantityToAdd;
        notifyListeners();
        return;
      }
    }
    _cartItems.add(CartItem(product: product, quantity: quantityToAdd));
    notifyListeners();
  }

  void removeFromCart(CartItem cartItem) {
    _cartItems.remove(cartItem);
    notifyListeners();
  }

  void increaseQuantity(CartItem cartItem) {
    cartItem.quantity++;
    notifyListeners();
  }

  void decreaseQuantity(CartItem cartItem) {
    if (cartItem.quantity > 1) {
      cartItem.quantity--;
    } else {
      _cartItems.remove(cartItem);
    }
    notifyListeners();
  }

  double getTotalPrice() {
    double total = 0;
    for (var item in _cartItems) {
      final price = item.product['price'];
      if (price is num) {
        total += price * item.quantity;
      }
    }
    return total;
  }
}
