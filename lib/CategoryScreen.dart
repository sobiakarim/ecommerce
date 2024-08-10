import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaselogin/feedback.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'CartScreen.dart';
import 'CategoryItemScreen.dart';
import 'WishListScreen.dart';
import 'item_model.dart';
import 'loginscreen.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final List<Category> categories = [
    Category(
      name: 'Electronics',
      imageUrl: 'https://images.pexels.com/photos/356056/pexels-photo-356056.jpeg?auto=compress&cs=tinysrgb&w=600',
    ),
    Category(
      name: 'Clothing',
      imageUrl: 'https://media.istockphoto.com/id/1257563298/photo/fashion-clothes-on-a-rack-in-a-light-background-indoors-place-for-text.jpg?s=2048x2048&w=is&k=20&c=1LBZ7fcMbsUh1psCViG48H6r1P9MRkSjqtw73v10-s8=',
    ),
    Category(
      name: 'Home Appliances',
      imageUrl: 'https://images.pexels.com/photos/5824883/pexels-photo-5824883.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    ),
    Category(
      name: 'Books',
      imageUrl: 'https://images.pexels.com/photos/159866/books-book-pages-read-literature-159866.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    ),
    Category(
      name: 'Beauty Products',
      imageUrl: 'https://images.pexels.com/photos/3148938/pexels-photo-3148938.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    ),
    Category(
      name: 'Toys',
      imageUrl: 'https://images.pexels.com/photos/191360/pexels-photo-191360.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    ),
  ];

  late Box<Item> wishlistBox;
  late Box<Item> cartBox;

  @override
  void initState() {
    super.initState();
    wishlistBox = Hive.box<Item>('wishlist');
    cartBox = Hive.box<Item>('cart');
  }

  void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories', style: TextStyle(color: Colors.white),),
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              final wishlistItems = wishlistBox.values.toList();
              navigateToScreen(context, WishlistScreen(wishlistItems));
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              final cartItems = cartBox.values.toList();
              navigateToScreen(context, CartScreen(cartItems));
            },
          ),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>FeedbackScreen()));
          } , icon: Icon(Icons.feedback)),
          IconButton(onPressed: (){
            final auth = FirebaseAuth.instance;
            auth.signOut();
            Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
          }, icon: Icon(Icons.logout))
        ],
      ),
      backgroundColor: Colors.white,
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: categories.length,
        itemBuilder: (ctx, i) => CategoryItem(
          categories[i].name,
          categories[i].imageUrl,
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String name;
  final String imageUrl;

  CategoryItem(this.name, this.imageUrl);

  void selectCategory(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return CategoryItemsScreen(name);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,  // Align the text at the bottom center
          child: Container(
            color: Colors.black87,  // Background color for better visibility
            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0), // Optional padding around text
            child: Text(
              name,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),

    );
  }
}

class Category {
  final String name;
  final String imageUrl;

  Category({
    required this.name,
    required this.imageUrl,
  });
}
