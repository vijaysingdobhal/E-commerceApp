import 'dart:convert';
import 'package:ecommerceapp/Model/CartItem.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartService {
  static final CartService _instance = CartService._internal();

  factory CartService() {
    return _instance;
  }

  CartService._internal();

  final List<CartItem> _cartItems = [];
  final List<VoidCallback> _listeners = [];
  static const String _cartKey = 'cartItems';

  List<CartItem> get cartItems => _cartItems;

  Future<void> init() async {
    await _loadCart();
  }

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

  Future<void> _saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> cartJson = _cartItems.map((item) => json.encode(item.toJson())).toList();
    await prefs.setStringList(_cartKey, cartJson);
  }

  Future<void> _loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? cartJson = prefs.getStringList(_cartKey);
    if (cartJson != null) {
      _cartItems.clear();
      _cartItems.addAll(cartJson.map((item) => CartItem.fromJson(json.decode(item))));
      notifyListeners();
    }
  }

  void addToCart(dynamic product) {
    final int quantityToAdd = product['quantity'] as int? ?? 1;
    for (var item in _cartItems) {
      if (item.product['id'] == product['id']) {
        item.quantity += quantityToAdd;
        _saveCart();
        notifyListeners();
        return;
      }
    }
    _cartItems.add(CartItem(product: product, quantity: quantityToAdd));
    _saveCart();
    notifyListeners();
  }

  void removeFromCart(CartItem cartItem) {
    _cartItems.remove(cartItem);
    _saveCart();
    notifyListeners();
  }

  void increaseQuantity(CartItem cartItem) {
    cartItem.quantity++;
    _saveCart();
    notifyListeners();
  }

  void decreaseQuantity(CartItem cartItem) {
    if (cartItem.quantity > 1) {
      cartItem.quantity--;
    } else {
      _cartItems.remove(cartItem);
    }
    _saveCart();
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
