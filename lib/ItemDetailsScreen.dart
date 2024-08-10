import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'item_model.dart';

class ItemDetailsScreen extends StatelessWidget {
  final Item item;

  ItemDetailsScreen(this.item);

  void addToCart(BuildContext context) {
    final cartBox = Hive.box<Item>('cart');
    if (!cartBox.values.any((existingItem) => existingItem.name == item.name)) {
      cartBox.add(item);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${item.name} added to cart'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${item.name} is already in your cart'),
      ));
    }
  }

  void addToWishlist(BuildContext context) {
    final wishlistBox = Hive.box<Item>('wishlist');
    if (!wishlistBox.values.any((existingItem) => existingItem.name == item.name)) {
      wishlistBox.add(item);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${item.name} added to wishlist'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${item.name} is already in your wishlist'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          item.name,
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(item.imageUrl),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                item.description,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                '\$${item.price}',
                style: TextStyle(fontSize: 24, color: Colors.black),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => addToCart(context),
                  child: Text(
                    'Add to Cart',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                ),
                ElevatedButton(
                  onPressed: () => addToWishlist(context),
                  child: Text(
                    'Add to Wishlist',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
