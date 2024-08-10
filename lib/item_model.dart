import 'package:hive/hive.dart';

part 'item_model.g.dart';

@HiveType(typeId: 0)
class Item extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String description;

  @HiveField(2)
  double price;

  @HiveField(3)
  String imageUrl;

  @HiveField(4)
  int quantity;  // New field for quantity

  Item({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.quantity = 1,  // Default quantity is 1
  });
}
