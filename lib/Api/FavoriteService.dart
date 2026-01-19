import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteService extends Notifier<List<dynamic>> {
  static const String _favoriteKey = 'favoriteItems';

  Future<void> init() async {
    await _loadFavorites();
  }

  @override
  List<dynamic> build() {
    return [];
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? favoriteJson = prefs.getStringList(_favoriteKey);
    if (favoriteJson != null) {
      state = favoriteJson.map((item) => json.decode(item)).toList();
    } else {
      state = [];
    }
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> favoriteJson = state.map((item) => json.encode(item)).toList();
    await prefs.setStringList(_favoriteKey, favoriteJson);
  }

  bool isFavorite(dynamic product) {
    return state.any((item) => item['id'] == product['id']);
  }

  void toggleFavorite(dynamic product) {
    final isCurrentlyFavorite = isFavorite(product);
    if (isCurrentlyFavorite) {
      state = state.where((item) => item['id'] != product['id']).toList();
    } else {
      state = [...state, product];
    }
    _saveFavorites();
  }
}

final favoriteServiceProvider = NotifierProvider<FavoriteService, List<dynamic>>(FavoriteService.new);

final favoriteFutureProvider = FutureProvider<void>((ref) async {
  await ref.read(favoriteServiceProvider.notifier).init();
});

final isFavoriteProvider = Provider.family<bool, dynamic>((ref, product) {
  final favoriteItems = ref.watch(favoriteServiceProvider);
  return favoriteItems.any((item) => item['id'] == product['id']);
});
