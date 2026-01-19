import 'package:ecommerceapp/Api/ApiService.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final apiServiceProvider = Provider((ref) => ApiService());

final productsProvider = FutureProvider<List<dynamic>>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.getAllProducts();
});

final selectedCategoryProvider = StateProvider<String>((ref) => 'All');
