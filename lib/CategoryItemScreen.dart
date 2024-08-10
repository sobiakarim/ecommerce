import 'package:flutter/material.dart';

import 'ItemDetailsScreen.dart';
import 'item_model.dart';

class CategoryItemsScreen extends StatefulWidget {
  final String categoryName;

  CategoryItemsScreen(this.categoryName);

  @override
  _CategoryItemsScreenState createState() => _CategoryItemsScreenState();
}

class _CategoryItemsScreenState extends State<CategoryItemsScreen> {
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  final Map<String, List<Item>> categoryItems = {
    'Electronics': [
      Item(
          name: 'Smartphone',
          description: 'Brand: XYZ, Model: Alpha 12',
          price: 799.0,
          imageUrl: 'https://images.pexels.com/photos/1092644/pexels-photo-1092644.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'
      ),
      Item(
          name: 'Laptop',
          description: 'Brand: ABC, Model: Speedster 15',
          price: 1199.0,
          imageUrl: 'https://images.pexels.com/photos/129208/pexels-photo-129208.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'
      ),
      Item(
          name: 'Smartwatch',
          description: 'Brand: DEF, Model: TimePro',
          price: 199.0,
          imageUrl: 'https://images.pexels.com/photos/3783416/pexels-photo-3783416.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'
      ),
      Item(
          name: 'Headphones',
          description: 'Brand: GHI, Model: SoundMax',
          price: 149.0,
          imageUrl: 'https://images.pexels.com/photos/1649771/pexels-photo-1649771.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'
      ),
      Item(
          name: 'Tablet',
          description: 'Brand: JKL, Model: TabStar',
          price: 499.0,
          imageUrl: 'https://images.pexels.com/photos/1334597/pexels-photo-1334597.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'
      ),
    ],
    'Clothing': [
      Item(
          name: 'T-Shirt',
          description: 'Brand: FashionCo, Size: M, Color: Blue',
          price: 25.0,
          imageUrl: 'https://media.istockphoto.com/id/1323480815/photo/navy-t-shirt.jpg?s=2048x2048&w=is&k=20&c=Ydszzx-5Yn3LHcKXqYmiswGmaqloP4N5EMn_3v7-6j4='
      ),
      Item(
          name: 'Jeans',
          description: 'Brand: DenimWorld, Size: 32, Color: Black',
          price: 60.0,
          imageUrl: 'https://images.pexels.com/photos/1082528/pexels-photo-1082528.jpeg?auto=compress&cs=tinysrgb&w=600'
      ),
      Item(
          name: 'Jacket',
          description: 'Brand: WinterWear, Size: L, Color: Red',
          price: 120.0,
          imageUrl: 'https://media.istockphoto.com/id/1326352310/photo/blank-tracksuit-top-mockup.jpg?b=1&s=612x612&w=0&k=20&c=d7aKvaOaSsFsd2wM2ovS29oaRTeHwhk-Is8ZUo4H_8U='
      ),
      Item(
          name: 'Dress',
          description: 'Brand: Glamour, Size: S, Color: Green',
          price: 75.0,
          imageUrl: 'https://media.istockphoto.com/id/1440977634/photo/vertical-shot-of-the-beautiful-pink-dress-isolated-on-the-white-background.jpg?b=1&s=612x612&w=0&k=20&c=4_piA2edAWWWQ7VyUl7hWJy32yU4xuLE1-iKvKNm2Fk='
      ),
      Item(
          name: 'Sneakers',
          description: 'Brand: RunFast, Size: 10, Color: White',
          price: 85.0,
          imageUrl: 'https://images.pexels.com/photos/1598505/pexels-photo-1598505.jpeg?auto=compress&cs=tinysrgb&w=600'
      ),
    ],
    'Home Appliances': [
      Item(
          name: 'Refrigerator',
          description: 'Brand: CoolHome, Model: FreshX',
          price: 1500.0,
          imageUrl: 'https://images.pexels.com/photos/4058699/pexels-photo-4058699.jpeg?auto=compress&cs=tinysrgb&w=600'
      ),
      Item(
          name: 'Microwave Oven',
          description: 'Brand: HeatQuick, Model: MW500',
          price: 200.0,
          imageUrl: 'https://images.pexels.com/photos/5749098/pexels-photo-5749098.jpeg?auto=compress&cs=tinysrgb&w=600'
      ),
      Item(
          name: 'Washing Machine',
          description: 'Brand: CleanSpin, Model: WM1000',
          price: 800.0,
          imageUrl: 'https://images.pexels.com/photos/7282378/pexels-photo-7282378.jpeg?auto=compress&cs=tinysrgb&w=600'
      ),
      Item(
          name: 'Air Conditioner',
          description: 'Brand: ChillAir, Model: AC20',
          price: 600.0,
          imageUrl: 'https://media.istockphoto.com/id/1368514998/photo/hand-adjusting-temperature-on-air-conditioner.jpg?b=1&s=612x612&w=0&k=20&c=7PsfL0V8xLI_8ij1UQwYIBMknoWWc7KN6PLD8rsGsEE='
      ),
      Item(
          name: 'Vacuum Cleaner',
          description: 'Brand: DustAway, Model: V600',
          price: 250.0,
          imageUrl: 'https://images.pexels.com/photos/38325/vacuum-cleaner-carpet-cleaner-housework-housekeeping-38325.jpeg?auto=compress&cs=tinysrgb&w=600'
      ),
    ],
    'Books': [
      Item(
          name: 'Novel',
          description: 'Title: "The Adventure", Author: John Smith',
          price: 15.0,
          imageUrl: 'https://images.pexels.com/photos/734968/pexels-photo-734968.jpeg?auto=compress&cs=tinysrgb&w=600'
      ),
      Item(
          name: 'Cookbook',
          description: 'Title: "Quick Recipes", Author: Jane Doe',
          price: 20.0,
          imageUrl: 'https://images.pexels.com/photos/734968/pexels-photo-734968.jpeg?auto=compress&cs=tinysrgb&w=600'
      ),
      Item(
          name: 'Self-Help',
          description: 'Title: "Better You", Author: Max Power',
          price: 18.0,

          imageUrl: 'https://images.pexels.com/photos/734968/pexels-photo-734968.jpeg?auto=compress&cs=tinysrgb&w=600'
      ),
      Item(
          name: 'Science Fiction',
          description: 'Title: "Future World", Author: Lisa Ray',
          price: 22.0,
          imageUrl: 'https://images.pexels.com/photos/734968/pexels-photo-734968.jpeg?auto=compress&cs=tinysrgb&w=600'
      ),
      Item(
          name: 'Biography',
          description: 'Title: "Life of Legends", Author: Mark Twain',
          price: 25.0,
          imageUrl: 'https://images.pexels.com/photos/734968/pexels-photo-734968.jpeg?auto=compress&cs=tinysrgb&w=600'
      ),
    ],
    'Beauty Products': [
      Item(
          name: 'Face Cream',
          description: 'Brand: GlowUp, Model: Hydrate',
          price: 30.0,
          imageUrl: 'https://images.pexels.com/photos/5217926/pexels-photo-5217926.jpeg?auto=compress&cs=tinysrgb&w=600'
      ),
      Item(
          name: 'Shampoo',
          description: 'Brand: ShineHair, Model: Smooth',
          price: 15.0,
          imageUrl: 'https://images.pexels.com/photos/3735657/pexels-photo-3735657.jpeg?auto=compress&cs=tinysrgb&w=600'
      ),
      Item(
          name: 'Lipstick',
          description: 'Brand: ColorMe, Shade: Red',
          price: 20.0,
          imageUrl: 'https://images.pexels.com/photos/2533266/pexels-photo-2533266.jpeg?auto=compress&cs=tinysrgb&w=600'
      ),
      Item(
          name: 'Perfume',
          description: 'Brand: FragranceHouse, Scent: Floral',
          price: 50.0,
          imageUrl: 'https://images.pexels.com/photos/755992/pexels-photo-755992.jpeg?auto=compress&cs=tinysrgb&w=600'
      ),
      Item(
          name: 'Mascara',
          description: 'Brand: EyeCandy, Model: VolumeBoost',
          price: 18.0,
          imageUrl: 'https://images.pexels.com/photos/2637820/pexels-photo-2637820.jpeg?auto=compress&cs=tinysrgb&w=600'
      ),
    ],
    'Toys': [
      Item(
          name: 'Action Figure',
          description: 'Brand: SuperToys, Character: HeroX',
          price: 25.0,
          imageUrl: 'https://images.pexels.com/photos/231013/pexels-photo-231013.jpeg?auto=compress&cs=tinysrgb&w=600'
      ),
      Item(
          name: 'Doll',
          description: 'Brand: DreamDoll, Model: Princess',
          price: 30.0,
          imageUrl: 'https://images.pexels.com/photos/1192349/pexels-photo-1192349.jpeg?auto=compress&cs=tinysrgb&w=600'
      ),
      Item(
          name: 'Building Blocks',
          description: 'Brand: BuildFun, Pieces: 1000',
          price: 40.0,
          imageUrl: 'https://images.pexels.com/photos/4399406/pexels-photo-4399406.jpeg?auto=compress&cs=tinysrgb&w=600'
      ),
      Item(
          name: 'Board Game',
          description: 'Brand: PlayTime, Game: StrategyQuest',
          price: 35.0,
          imageUrl: 'https://images.pexels.com/photos/459275/pexels-photo-459275.jpeg?auto=compress&cs=tinysrgb&w=600'
      ),
      Item(
          name: 'Puzzle',
          description: 'Brand: BrainTease, Pieces: 500',
          price: 20.0,
          imageUrl: 'https://images.pexels.com/photos/3852577/pexels-photo-3852577.jpeg?auto=compress&cs=tinysrgb&w=600'
      ),
    ],
  };

  @override
  Widget build(BuildContext context) {
    final items = categoryItems[widget.categoryName] ?? [];
    final filteredItems = items.where((item) {
      return item.name.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.categoryName,
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(56.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search items...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: filteredItems.length,
        itemBuilder: (ctx, i) => CategoryItemCard(filteredItems[i]),
      ),
    );
  }
}

class CategoryItemCard extends StatelessWidget {
  final Item item;

  CategoryItemCard(this.item);

  void selectItem(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return ItemDetailsScreen(item);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectItem(context),
      child: GridTile(
        child: Image.network(item.imageUrl, fit: BoxFit.cover),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          title: Text(
            item.name,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
