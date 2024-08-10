import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'item_model.dart';

class WishlistScreen extends StatefulWidget {
  final List<Item> wishlist;

  WishlistScreen(this.wishlist);

  @override
  _WishlistScreenState createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  late Box<Item> wishlistBox;

  @override
  void initState() {
    super.initState();
    wishlistBox = Hive.box<Item>('wishlist');
  }

  void _removeFromWishlist(Item item) {
    final keyToRemove = wishlistBox.keys.firstWhere(
          (key) => wishlistBox.get(key) == item,
      orElse: () => null,
    );

    if (keyToRemove != null) {
      wishlistBox.delete(keyToRemove);
      setState(() {
        widget.wishlist.remove(item);
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${item.name} removed from wishlist'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: widget.wishlist.length,
        itemBuilder: (ctx, i) => WishlistItemCard(widget.wishlist[i], _removeFromWishlist),
      ),
    );
  }
}

class WishlistItemCard extends StatelessWidget {
  final Item item;
  final Function(Item) onRemove;

  WishlistItemCard(this.item, this.onRemove);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(item.imageUrl, width: 50, height: 50),
        title: Text(item.name),
        subtitle: Text('\$${item.price}'),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: () => onRemove(item),
        ),
      ),
    );
  }
}
