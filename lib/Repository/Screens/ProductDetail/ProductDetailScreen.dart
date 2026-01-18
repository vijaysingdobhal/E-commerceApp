import 'package:ecommerceapp/Api/CartService.dart';
import 'package:ecommerceapp/Api/FavoriteService.dart';
import 'package:ecommerceapp/Domain/Constant/appcolor.dart';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatefulWidget {
  final dynamic product;

  const ProductDetailScreen({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 1;
  bool _isFavorite = false;
  final FavoriteService _favoriteService = FavoriteService();
  final CartService _cartService = CartService();

  @override
  void initState() {
    super.initState();
    _isFavorite = _favoriteService.isFavorite(widget.product);
    _favoriteService.addListener(_onFavoriteChanged);
  }

  @override
  void dispose() {
    _favoriteService.removeListener(_onFavoriteChanged);
    super.dispose();
  }

  void _onFavoriteChanged() {
    setState(() {
      _isFavorite = _favoriteService.isFavorite(widget.product);
    });
  }

  void _toggleFavorite() {
    _favoriteService.toggleFavorite(widget.product);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.cardColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Appcolor.textColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Appcolor.textColor),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(_isFavorite ? Icons.favorite : Icons.favorite_border, color: Appcolor.primaryColor),
            onPressed: _toggleFavorite,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  widget.product['image'],
                  height: 300,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                widget.product['title'],
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Appcolor.textColor),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 20),
                  const SizedBox(width: 5),
                  Text(
                    '4.8 (320 Review)',
                    style: const TextStyle(fontSize: 16, color: Appcolor.secondaryTextColor),
                  ),
                  const Spacer(),
                  Text(
                    'Seller: Syed Noman',
                    style: const TextStyle(fontSize: 16, color: Appcolor.secondaryTextColor),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Color',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Appcolor.textColor),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  _buildColorOption(Colors.black, isSelected: true),
                  const SizedBox(width: 10),
                  _buildColorOption(Colors.red),
                  const SizedBox(width: 10),
                  _buildColorOption(Colors.orange),
                  const SizedBox(width: 10),
                  _buildColorOption(Colors.blue),
                   const SizedBox(width: 10),
                  _buildColorOption(Colors.grey),
                ],
              ),
              const SizedBox(height: 20),

              DefaultTabController(
                length: 3,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const TabBar(
                      isScrollable: true,
                      labelColor: Appcolor.cardColor,
                      unselectedLabelColor: Appcolor.textColor,
                      indicator: BoxDecoration(
                        color: Appcolor.primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      tabs: [
                        Tab(text: 'Description'),
                        Tab(text: 'Specifications'),
                        Tab(text: 'Reviews'),
                      ],
                    ),
                    SizedBox(
                      height: 150, // Adjust height as needed
                      child: TabBarView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                             widget.product['description'] ?? 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                            ),
                          ),
                          const Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Specifications content goes here.'),
                          ),
                          const Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Reviews content goes here.'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildColorOption(Color color, {bool isSelected = false}) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: isSelected ? Border.all(color: Appcolor.primaryColor, width: 2) : null,
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Appcolor.textColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    if (quantity > 1) {
                      setState(() {
                        quantity--;
                      });
                    }
                  },
                  icon: const Icon(Icons.remove, color: Appcolor.cardColor),
                ),
                Text(
                  '$quantity',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Appcolor.cardColor),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      quantity++;
                    });
                  },
                  icon: const Icon(Icons.add, color: Appcolor.cardColor),
                ),
              ],
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  final productToAdd = Map<String, dynamic>.from(widget.product);
                  productToAdd['quantity'] = quantity;
                  _cartService.addToCart(productToAdd);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Product added to cart'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Appcolor.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                ),
                child: const Text('Add to Cart', style: TextStyle(color: Appcolor.cardColor, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
