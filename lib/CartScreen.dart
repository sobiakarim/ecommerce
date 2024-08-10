import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'item_model.dart';
import 'roundbutton.dart';  // Assuming this is your custom round button

class CartScreen extends StatefulWidget {
  final List<Item> cartItems;

  CartScreen(this.cartItems);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late Box<Item> cartBox;

  @override
  void initState() {
    super.initState();
    cartBox = Hive.box<Item>('cart');
  }

  void _increaseQuantity(Item item) {
    setState(() {
      item.quantity += 1;
      item.save(); // Update in Hive
    });
  }

  void _decreaseQuantity(Item item) {
    setState(() {
      if (item.quantity > 1) {
        item.quantity -= 1;
        item.save(); // Update in Hive
      }
    });
  }

  double get _totalAmount {
    return widget.cartItems.fold(
      0.0,
          (sum, item) => sum + (item.price * item.quantity),
    );
  }

  void _onCheckout() {
    // Handle checkout logic here, like navigating to a payment screen
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Checkout'),
        content: Text('Proceed to checkout? Total amount: \$${_totalAmount.toStringAsFixed(2)}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop(); // Close dialog
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Perform checkout actions here
              Navigator.of(ctx).pop(); // Close dialog
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Checkout successful!')),
              );
            },
            child: Text('Confirm'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.cartItems.length,
              itemBuilder: (ctx, i) => CartItemCard(
                item: widget.cartItems[i],
                onIncrease: () => _increaseQuantity(widget.cartItems[i]),
                onDecrease: () => _decreaseQuantity(widget.cartItems[i]),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  '\$${_totalAmount.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Roundbutton(
              title: 'Checkout',
              onTap: _onCheckout,
            ),
          ),
        ],
      ),
    );
  }
}

class CartItemCard extends StatelessWidget {
  final Item item;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  CartItemCard({
    required this.item,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(item.imageUrl, width: 50, height: 50),
        title: Text(item.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('\$${item.price}'),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: onDecrease,
                ),
                Text('${item.quantity}'),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: onIncrease,
                ),
              ],
            ),
          ],
        ),
        trailing: Text(
          '\$${(item.price * item.quantity).toStringAsFixed(2)}',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
