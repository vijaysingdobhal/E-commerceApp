import 'package:ecommerceapp/Api/ApiService.dart';
import 'package:ecommerceapp/Api/CartService.dart';
import 'package:ecommerceapp/Api/FavoriteService.dart';
import 'package:ecommerceapp/Domain/Constant/appcolor.dart';
import 'package:ecommerceapp/Repository/Screens/ProductDetail/ProductDetailScreen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<dynamic>> _products;
  final CartService _cartService = CartService();
  final FavoriteService _favoriteService = FavoriteService();
  String _selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    _products = ApiService().getAllProducts();
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
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchBar(),
              const SizedBox(height: 24),
              _buildSaleBanner(),
              const SizedBox(height: 24),
              _buildCategoryList(),
              const SizedBox(height: 24),
              _buildSectionTitle(title: "Special For You", onSeeAll: () {}),
              const SizedBox(height: 16),
              _buildProductGrid(),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Appcolor.scaffoldbackgrount,
      leading: const Icon(Icons.grid_view_rounded, color: Appcolor.textColor),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none_outlined, color: Appcolor.textColor),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search...",
        hintStyle: const TextStyle(color: Appcolor.secondaryTextColor),
        prefixIcon: const Icon(Icons.search, color: Appcolor.secondaryTextColor, size: 20),
        suffixIcon: const Icon(Icons.filter_list, color: Appcolor.secondaryTextColor, size: 20),
        filled: true,
        fillColor: Appcolor.cardColor,
        contentPadding: const EdgeInsets.all(8),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Appcolor.cardColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Appcolor.cardColor),
        ),
      ),
    );
  }

  Widget _buildSaleBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Appcolor.accentColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Super Sale",
                  style: TextStyle(
                      color: Appcolor.textColor, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "Discount up to 50%",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Appcolor.textColor,
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Appcolor.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text("Shop Now"),
                ),
              ],
            ),
          ),
          Image.asset(
            'Assets/Images/shoes.png',
            width: 120,
            height: 120,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryList() {
    final List<Map<String, dynamic>> categories = [
      {'icon': Icons.apps, 'name': 'All'},
      {'icon': Icons.directions_walk, 'name': 'Shoes'},
      {'icon': Icons.man, 'name': 'Men\'s'},
      {'icon': Icons.watch, 'name': 'Watches'},
      {'icon': Icons.headphones, 'name': 'Electronics'},
    ];

    return SizedBox(
      height: 70,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category['name'] == _selectedCategory;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategory = category['name'];
              });
            },
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isSelected ? Appcolor.primaryColor : Appcolor.cardColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(category['icon'], color: isSelected ? Appcolor.cardColor : Appcolor.textColor),
                ),
                const SizedBox(height: 4),
                Text(
                  category['name'],
                  style: TextStyle(fontSize: 12, color: isSelected ? Appcolor.primaryColor : Appcolor.secondaryTextColor),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 20),
      ),
    );
  }

  Widget _buildSectionTitle({required String title, required VoidCallback onSeeAll}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Appcolor.textColor),
        ),
        TextButton(
          onPressed: onSeeAll,
          child: const Text(
            "See all",
            style: TextStyle(color: Appcolor.primaryColor),
          ),
        ),
      ],
    );
  }

  Widget _buildProductGrid() {
    return FutureBuilder<List<dynamic>>(
      future: _products,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No products found"));
        } else {
          final products = snapshot.data!;
          final filteredProducts = products.where((product) {
            if (_selectedCategory == 'All') {
              return true;
            }
            // The API categories are lowercase
            String apiCategory = product['category'].toString().toLowerCase();
            String selectedCategory = _selectedCategory.toLowerCase();

            if (selectedCategory == "men's") {
              selectedCategory = "men's clothing";
            }

            // The API does not have a 'shoes' or 'watches' category, so that will result in an empty list.
            // This is expected given the API.
            return apiCategory == selectedCategory;

          }).toList();

          if (filteredProducts.isEmpty) {
            return const Center(child: Text("No products found in this category"));
          }

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.8,
            ),
            itemCount: filteredProducts.length,
            itemBuilder: (context, index) {
              final product = filteredProducts[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailScreen(product: product),
                    ),
                  );
                },
                child: _buildProductItem(
                  product: product,
                ),
              );
            },
          );
        }
      },
    );
  }

  Widget _buildProductItem({required dynamic product}) {
    final isFavorite = _favoriteService.isFavorite(product);
    return Container(
      decoration: BoxDecoration(
        color: Appcolor.cardColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(12.0),
                  child: Image.network(product['image']),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 0, 12.0, 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        product['title'],
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          color: Appcolor.textColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            '\$${product['price']}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Appcolor.textColor,
                            ),
                          ),
                          const Spacer(),
                          _buildColorSwatch(Colors.black),
                          const SizedBox(width: 4),
                          _buildColorSwatch(Colors.pink.shade200),
                          const SizedBox(width: 4),
                          _buildColorSwatch(Colors.orange.shade300),
                          const SizedBox(width: 4),
                          _buildColorSwatch(Colors.teal.shade300),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                _favoriteService.toggleFavorite(product);
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Appcolor.primaryColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Appcolor.cardColor,
                  size: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColorSwatch(Color color) {
    return Container(
      width: 14,
      height: 14,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Appcolor.cardColor, width: 1),
      ),
    );
  }
}
