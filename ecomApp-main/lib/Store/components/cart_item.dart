import 'package:flutter/animation.dart';

class Product {
  String name;
  String price;
  List<Color> colors;
  String desc;

  String cover;
  Product({
    required this.name,
    required this.price,
    required this.colors,
    required this.desc,
    required this.cover,
  });

  @override
  String toString() {
    return 'Shoe(name: $name, price: $price, colors: $colors, desc: $desc, cover: $cover)';
  }
}

class CartItem {
  Product product;
  int quantity;
  CartItem({
    required this.product,
    this.quantity = 1,
  });

  @override
  String toString() => 'CartItem(shoe: $product, quantity: $quantity)';
}
