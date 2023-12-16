import 'package:flutter/material.dart';

import 'Product.dart';

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
  AvailableSizes ?productSize;
  List<AvailableSizes>? availableSizes;
  Color ?productColor;
  List<Color>? availableColors; // Change the type to List<Color>

  // Constructor
  Product({
    required this.ID,
    required this.name,
    required this.imageURL,
    required this.description,
    required this.price,
    required this.rating,
    this.productSize,
    this.availableSizes, // changed from AvailableSizes to availableSizes
    this.productColor,
    this.availableColors,
    // TODO: add material
  });

  // String getSize() {
  //   if (productSize != null) {
  //     return productSize.toString().split('.').last; // Convert enum to string
  //   } else {
  //     return 'Unknown Size';
  //   }
  // }
  String getSize() => productSize?.toString().split('.').last ?? 'Unknown Size';

  String productSizeToString() {
    return productSize != null
        ? productSize.toString().split('.').last
        : 'Unknown Size';
  }
  //
  // static String colorToHex(Color color) {
  //   return '#${color.value.toRadixString(16).substring(2)}';
  // }


  void getProductDetails() {
    print('Product ID: $ID');
    print('Product Name: $name');
    print('Product Image URL: $imageURL');
    print('Product Description: $description');
    print('Product Price: $price');
    print('Product Rating: $rating');
    print('Product Size: $getSize()');
    print('Product Available Sizes: $availableSizes');
    print('Product Color: $productColor');
    print('Product Available Colors: $availableColors');
  }


}

List<Product> products = [
  // TODO: create list of unique products and list of all products
  Product(
    ID: 'T3', name: 'Transparent Hoodie', imageURL: 'assets/images/brown_hoodie2.jpeg',
    description: 'Tells the time', price: 49.99, rating: 5.0,
    productSize: AvailableSizes.M, availableSizes: [AvailableSizes.M, AvailableSizes.L],
  ),
  Product(
    ID: 'T3', name: 'Transparent Hoodie', imageURL: 'assets/images/brown_hoodie2.jpeg',
    description: 'Tells the time', price: 299.99, rating: 5.0,
    productSize: AvailableSizes.L, availableSizes: [AvailableSizes.M, AvailableSizes.L],
  ),
  Product(
    ID: 'T1', name: 'Blue Hoodie', imageURL: 'assets/images/blue_hoodie1.jpg',
    description: 'Comfortable cotton t-shirt', price: 19.99, rating: 4.2,
    productSize: AvailableSizes.M, availableSizes: [AvailableSizes.M, AvailableSizes.L],
    productColor: Colors.blue, availableColors: [Colors.blue, Colors.red],
  ),
  Product(
    ID: 'T1', name: 'Red Hoodie', imageURL: 'assets/images/red_hoodie1.jpg',
    description: 'Comfortable cotton t-shirt', price: 19.99, rating: 4.2,
    productSize: AvailableSizes.M, availableSizes: [AvailableSizes.M, AvailableSizes.L],
    productColor: Colors.red, availableColors: [Colors.blue, Colors.red],
  ),
  Product(
    ID: 'T1', name: 'Blue Hoodie', imageURL: 'assets/images/blue_hoodie1.jpg',
    description: 'Comfortable Hoodie', price: 24.99, rating: 4.2,
    productSize: AvailableSizes.L, availableSizes: [AvailableSizes.M, AvailableSizes.L],
    productColor: Colors.blue, availableColors: [Colors.blue, Colors.red],
  ),
  Product(
    ID: 'T1', name: 'Red Hoodie', imageURL: 'assets/images/red_hoodie1.jpg',
    description: 'Comfortable Hoodie', price: 27.99, rating: 4.2,
    productSize: AvailableSizes.L, availableSizes: [AvailableSizes.M, AvailableSizes.L],
    productColor: Colors.red, availableColors: [Colors.blue, Colors.red],
  ),
  Product(
    ID: 'T2', name: 'Green Sweater', imageURL: 'assets/images/green_sweater1.jpg',
    description: 'Warm wool sweater for winter', price: 29.99, rating: 4.5,
    productSize: AvailableSizes.M, availableSizes: [AvailableSizes.M, AvailableSizes.XL],
    productColor: Colors.green, availableColors: [Colors.green, Colors.black],
  ),
  Product(
    ID: 'T2', name: 'Green Sweater', imageURL: 'assets/images/green_sweater1.jpg',
    description: 'Warm wool sweater for winter', price: 49.99, rating: 4.5,
    productSize: AvailableSizes.XL, availableSizes: [AvailableSizes.M, AvailableSizes.XL],
    productColor: Colors.green, availableColors: [Colors.green, Colors.black],
  ),
  Product(
    ID: 'T2', name: 'Black Sweater', imageURL: 'assets/images/black_sweater1.jpg',
    description: 'Warm wool sweater for winter', price: 29.99, rating: 4.5,
    productSize: AvailableSizes.M, availableSizes: [AvailableSizes.M, AvailableSizes.XL],
    productColor: Colors.black, availableColors: [Colors.green, Colors.black],
  ),
  Product(
    ID: 'T2', name: 'Black Sweater', imageURL: 'assets/images/black_sweater1.jpg',
    description: 'Warm wool sweater for winter', price: 49.99, rating: 4.5,
    productSize: AvailableSizes.XL, availableSizes: [AvailableSizes.M, AvailableSizes.XL],
    productColor: Colors.black, availableColors: [Colors.green, Colors.black],
  ),
  Product(
    ID: 'B1', name: 'Blue Jeans', imageURL: 'assets/images/blue_jeans1.jpg',
    description: 'Classic denim jeans', price: 39.99, rating: 4.0,
    // productSize: AvailableSizes.M, availableSizes: [AvailableSizes.M],
    productColor: Colors.blue, availableColors: [Colors.blue, Colors.black],
  ),
  Product(
    ID: 'B1', name: 'Black Jeans', imageURL: 'assets/images/black_jeans1.jpg',
    description: 'Classic denim jeans', price: 49.99, rating: 4.0,
    // productSize: AvailableSizes.M, availableSizes: [AvailableSizes.M],
    productColor: Colors.black, availableColors: [Colors.blue, Colors.black],
  ),
  // Product(
  //   ID: 'B1', name: 'Blue Jeans', imageURL: 'assets/images/blue_jeans1.jpg',
  //   description: 'Classic denim jeans', price: 59.99, rating: 4.0,
  //   productSize: AvailableSizes.M, availableSizes: [AvailableSizes.S, AvailableSizes.M],
  //   productColor: Colors.blue, availableColors: [Colors.blue, Colors.black],
  // ),
  // Product(
  //   ID: 'B1', name: 'Black Jeans', imageURL: 'assets/images/black_jeans1.jpg',
  //   description: 'Classic denim jeans', price: 59.99, rating: 4.0,
  //   productSize: AvailableSizes.M, availableSizes: [AvailableSizes.S, AvailableSizes.M],
  //   productColor: Colors.black, availableColors: [Colors.blue, Colors.black],
  // ),
  Product(
    ID: 'S1', name: 'Black Shoes', imageURL: 'assets/images/black_shoe1.jpg',
    description: 'Amazing Shoes', price: 49.99, rating: 5.0,
    productSize: AvailableSizes.M, availableSizes: [AvailableSizes.M],
    productColor: Colors.black, availableColors: [Colors.black, Colors.red],
  ),
  Product(
    ID: 'S1', name: 'Red Shoes', imageURL: 'assets/images/red_shoe1.jpg',
    description: 'Amazing Shoes', price: 49.99, rating: 5.0,
    productSize: AvailableSizes.S, availableSizes: [AvailableSizes.S, AvailableSizes.M],
    productColor: Colors.red, availableColors: [Colors.red],
  ),
  Product(
    ID: 'S1', name: 'Red Shoes', imageURL: 'assets/images/red_shoe1.jpg',
    description: 'Amazing Shoes', price: 79.99, rating: 5.0,
    productSize: AvailableSizes.M, availableSizes: [AvailableSizes.S, AvailableSizes.M],
    productColor: Colors.red, availableColors: [Colors.black, Colors.red],
  ),
  Product(
    ID: 'A1', name: 'White Watch', imageURL: 'assets/images/white_watch1.jpg',
    description: 'Tells the time', price: 49.99, rating: 5.0,
    productSize: AvailableSizes.M, availableSizes: [AvailableSizes.M],
    productColor: Colors.white, availableColors: [ Colors.black, Colors.white],
  ),
  Product(
    ID: 'A1', name: 'Black Watch', imageURL: 'assets/images/black_watch1.png',
    description: 'Tells the time', price: 49.99, rating: 5.0,
    productSize: AvailableSizes.M, availableSizes: [AvailableSizes.M],
    productColor: Colors.black, availableColors: [ Colors.black, Colors.white],
  // Add more products as needed
  ),
];

List<Product> uniqueProducts = [];

void groupProducts(){
  print('started FN');
  for (Product product in products) {
    bool isUnique = true;
    for (Product uniqueProduct in uniqueProducts) {
      if (product.ID == uniqueProduct.ID) {
        isUnique = false;
        print('non unique product: \n');
        product.getProductDetails();
        break;
      }
    }
    if (isUnique) {
      uniqueProducts.add(product);
      print('unique product added: \n');
      product.getProductDetails();
    }
  }
}
