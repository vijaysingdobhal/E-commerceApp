import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteService {
  static final FavoriteService _instance = FavoriteService._internal();

  factory FavoriteService() {
    return _instance;
  }

  FavoriteService._internal();

  final List<dynamic> _favoriteItems = [];
  final List<VoidCallback> _listeners = [];
  static const String _favoriteKey = 'favoriteItems';

  List<dynamic> get favoriteItems => _favoriteItems;

  Future<void> init() async {
    await _loadFavorites();
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

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> favoriteJson =
        _favoriteItems.map((item) => json.encode(item)).toList();
    await prefs.setStringList(_favoriteKey, favoriteJson);
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? favoriteJson = prefs.getStringList(_favoriteKey);
    if (favoriteJson != null) {
      _favoriteItems.clear();
      _favoriteItems.addAll(favoriteJson.map((item) => json.decode(item)));
      notifyListeners();
    }
  }

  bool isFavorite(dynamic product) {
    return _favoriteItems.any((item) => item['id'] == product['id']);
  }

  void toggleFavorite(dynamic product) {
    if (isFavorite(product)) {
      _favoriteItems.removeWhere((item) => item['id'] == product['id']);
    } else {
      _favoriteItems.add(product);
    }
    _saveFavorites();
    notifyListeners();
  }
}
