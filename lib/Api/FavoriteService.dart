import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteService {
  static const _favoritesKey = 'favorites';

  Future<List<dynamic>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesString = prefs.getString(_favoritesKey) ?? '[]';
    return json.decode(favoritesString);
  }

  Future<void> addToFavorites(dynamic product) async {
    final prefs = await SharedPreferences.getInstance();
    List<dynamic> favorites = await getFavorites();
    if (!favorites.any((item) => item['id'] == product['id'])) {
      favorites.add(product);
      await prefs.setString(_favoritesKey, json.encode(favorites));
    }
  }

  Future<void> removeFromFavorites(dynamic product) async {
    final prefs = await SharedPreferences.getInstance();
    List<dynamic> favorites = await getFavorites();
    favorites.removeWhere((item) => item['id'] == product['id']);
    await prefs.setString(_favoritesKey, json.encode(favorites));
  }

  Future<bool> isFavorite(dynamic product) async {
    List<dynamic> favorites = await getFavorites();
    return favorites.any((item) => item['id'] == product['id']);
  }
}
