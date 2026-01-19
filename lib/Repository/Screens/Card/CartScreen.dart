import 'package:ecommerceapp/Api/CartService.dart';
import 'package:ecommerceapp/Domain/Constant/appcolor.dart';
import 'package:ecommerceapp/Model/CartItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../BottomNov/BottomNavScreen.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartAsyncValue = ref.watch(cartFutureProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Appcolor.textColor),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const BottomNavScreen()),
            );
          },
        ),
        title: const Text('My Cart', style: TextStyle(color: Appcolor.textColor)),
        centerTitle: true,
        backgroundColor: Appcolor.cardColor,
        elevation: 0,
      ),
      body: cartAsyncValue.when(
        data: (_) {
          final cartItems = ref.watch(cartServiceProvider);
          final cartNotifier = ref.read(cartServiceProvider.notifier);
          final cartTotal = ref.watch(cartTotalProvider);

          if (cartItems.isEmpty) {
            return const Center(child: Text("Your cart is empty"));
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final cartItem = cartItems[index];
                    return _buildCartItem(context, cartItem, cartNotifier);
                  },
                ),
              ),
              _buildCheckoutSection(cartTotal),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text("Error: $err")),
      ),
    );
  }

  Widget _buildCartItem(BuildContext context, CartItem cartItem, CartService cartNotifier) {
    final product = cartItem.product;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 0,
      color: Appcolor.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                product['image'],
                width: 80,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: SizedBox(
                height: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product['title'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Appcolor.textColor),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                product['category'] ?? "Watches",
                                style: const TextStyle(
                                    fontSize: 14, color: Appcolor.secondaryTextColor),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () => cartNotifier.removeFromCart(cartItem),
                          child: const Icon(Icons.delete_outline, color: Appcolor.primaryColor, size: 24),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '\$${product['price']}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Appcolor.textColor),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Appcolor.scaffoldbackgrount,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: () => cartNotifier.decreaseQuantity(cartItem),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                  child: Icon(Icons.remove, size: 16, color: Appcolor.secondaryTextColor),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Text(
                                  '${cartItem.quantity}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 16, color: Appcolor.textColor),
                                ),
                              ),
                              InkWell(
                                onTap: () => cartNotifier.increaseQuantity(cartItem),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                  child: Icon(Icons.add, size: 16, color: Appcolor.secondaryTextColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckoutSection(double cartTotal) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: const BoxDecoration(
        color: Appcolor.cardColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Appcolor.scaffoldbackgrount,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter Discount Code',
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Appcolor.secondaryTextColor),
                      ),
                      style: TextStyle(color: Appcolor.textColor),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Apply',
                    style: TextStyle(
                        color: Appcolor.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 24.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Subtotal',
                  style: TextStyle(
                      fontSize: 16, color: Appcolor.secondaryTextColor)),
              Text('\$${cartTotal.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Appcolor.textColor)),
            ],
          ),
          const SizedBox(height: 12.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total',
                  style: TextStyle(
                      fontSize: 16, color: Appcolor.secondaryTextColor)),
              Text('\$${cartTotal.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Appcolor.textColor)),
            ],
          ),
          const SizedBox(height: 24.0),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Appcolor.primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              onPressed: () {},
              child: const Text(
                'Checkout',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
