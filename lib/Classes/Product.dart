import 'dart:ui';
import 'package:flutter/material.dart';

enum AvailableSizes { S, M, L, XL, XXL, XXXL }

// enum ProductColor { Colors.Blue, Colors.Red, Colors.Green, Colors.Yellow, White, Black }
// enum ProductColor { Blue, Red, Green, Yellow, White, Black }


class Product {
  // String ?uniqueID; // ID that is unique to each product
  String ?ID; // ID that is common between same product but different variations
  String ?name;
  String ?imageURL;
  String ?description;
  double ?price;
  double ?rating;
  List<AvailableSizes>? availableSizes;
  List<Color>? availableColors; // Change the type to List<Color>

  // Constructor
  Product({
    required this.ID,
    required this.name,
    required this.imageURL,
    required this.description,
    required this.price,
    required this.rating,
    required this.availableSizes, // changed from AvailableSizes to availableSizes
    required this.availableColors,
  });
}

List<Product> products = [
  Product(
    ID: 'T1', name: 'T-Shirt', imageURL: 'assets/images/hoodie1.jpeg',
    description: 'Comfortable cotton t-shirt', price: 19.99, rating: 4.2,
    availableSizes: [AvailableSizes.S, AvailableSizes.M, AvailableSizes.L],
    availableColors: [Colors.blue, Colors.red],
  ),
  Product(
    ID: 'T2', name: 'Sweater', imageURL: 'assets/images/hoodie2.jpeg',
    description: 'Warm wool sweater for winter', price: 49.99, rating: 4.5,
    availableSizes: [AvailableSizes.M, AvailableSizes.L, AvailableSizes.XL],
    availableColors: [Colors.green, Colors.black],
  ),
  Product(
    ID: 'B1', name: 'Jeans', imageURL: 'assets/images/jeans1.jpg',
    description: 'Classic denim jeans', price: 39.99, rating: 4.0,
    availableSizes: [AvailableSizes.S, AvailableSizes.M],
    availableColors: [Colors.blue, Colors.black],
  ),
  Product(
    ID: 'S1', name: 'Shoes', imageURL: 'assets/images/shoe3.png',
    description: 'Amazing Shoes', price: 49.99, rating: 5.0,
    availableSizes: [AvailableSizes.S, AvailableSizes.M, AvailableSizes.L],
    availableColors: [Colors.blue, Colors.black, Colors.red],
  ),
  Product(
    ID: 'A1', name: 'Watch', imageURL: 'assets/images/watch1.png',
    description: 'Tells the time', price: 49.99, rating: 5.0,
    availableSizes: [],
    availableColors: [Colors.blue, Colors.black, Colors.white],
  ),
  // Add more products as needed
];