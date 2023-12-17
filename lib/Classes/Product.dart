import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
import 'package:slash_homepage_test/Classes/ProductVariation.dart';
import 'ProductProperty.dart';
import 'ProductPropertyandValue.dart';

// enum AvailableSizes { S, M, L, XL, XXL, XXXL }

// enum ProductColor { Colors.Blue, Colors.Red, Colors.Green, Colors.Yellow, White, Black }
// enum ProductColor { Blue, Red, Green, Yellow, White, Black }

class Product {
  // String ?uniqueID; // ID that is unique to each product
  String? ID; // ID that is common between same product but different variations
  String? name;
  // String ?imageURL;
  String? description;
  // double? price;
  double? rating;
  List<ProductVariation> variations; //! non nullable
  List<ProductProperty> availableProperties;  //What properties are offered
                                              // (multiple colors or non, multiple sizes or non, materials)
  //! availableProperties list all possible attributes but is is not necessary that all combination exist in variances
  // AvailableSizes ?productSize;
  // List<AvailableSizes>? availableSizes;
  // Color ?productColor;
  // List<Color>? availableColors; // Change the type to List<Color>

  // Constructor
  Product({
    required this.ID,
    required this.name,
    // required this.imageURL,
    required this.description,
    // required this.price,
    required this.rating,
    // this.productSize,
    // this.availableSizes, // changed from AvailableSizes to availableSizes
    // this.productColor,
    // this.availableColors,
    required this.variations,
    required this.availableProperties,
    // TODO: add material
  });

  void getProductDetails() {
    if (kDebugMode) {
      print('Product ID: $ID');
      print('Product Name: $name');
      print('Product Description: $description');
      print('Product Rating: $rating');
    }
    for (ProductVariation variant in variations) {
      if (kDebugMode) {
            variant.printVariationDetails();
      }
    }
  }

  void getVariationDetails(String variationID) {
    // Find the variation with the given variationID
    ProductVariation? selectedVariation;

    for (ProductVariation variation in variations) {
      if (variation.variationID == variationID) {
        selectedVariation = variation;
        break;
      }
    }

    if (selectedVariation != null) {
      if (kDebugMode) {
        print('Product Variation ID: ${selectedVariation.variationID}');
        print('Product Variation Price: ${selectedVariation.price}');
        print('Product Variation Images URLs: ${selectedVariation.productVariantImagesURLs}');
        print('Product Variation Properties:');
      }

      for (ProductPropertyandValue propertyValue in selectedVariation.productPropertiesValues) {
        if (kDebugMode) {
          print('Property: ${propertyValue.property}, Value: ${propertyValue.value}');
        }
      }
    } else {
      if (kDebugMode) {
        print('Product Variation not found with ID: $variationID');
      }
    }
  }

  ProductVariation getVariationByPropertiesValues({required List<ProductPropertyandValue> productPropertiesValues}) {
    if (kDebugMode) {
      print('\nsearching for variation with properties: ');
      printPropertyandValue(productPropertiesValues);
    }
    for (ProductVariation variation in variations) {
      if (variation.productPropertiesValues == productPropertiesValues) {
        return variation;
      }
    }
    return ProductVariation(
      ID: '',
      variationID: '',
      price: null,
      productVariantImagesURLs: const[],
      productPropertiesValues: const[],
    );
    // return null;
  }

  bool hasColors() {
    for (ProductProperty property in availableProperties) {
      if (property.property == 'color') {
        return true;
      }
    }
    return false;
  }

}

  // String getSize() {
  //   if (productSize != null) {
  //     return productSize.toString().split('.').last; // Convert enum to string
  //   } else {
  //     return 'Unknown Size';
  //   }
  // }
  // String getSize() => productSize?.toString().split('.').last ?? 'Unknown Size';

  // String productSizeToString() {
  //   return productSize != null
  //       ? productSize.toString().split('.').last
  //       : 'Unknown Size';
  // }
  //
  // static String colorToHex(Color color) {
  //   return '#${color.value.toRadixString(16).substring(2)}';
  // }


  // ProductProperty col = ProductProperty(property: 'color');
  // ProductProperty sizee = ProductProperty(property: 'size');
  // ProductProperty mat = ProductProperty(property: 'material');


// ! Product 1
Product p1 = Product(
  ID: 'T1',
  name: 'Hoodie',
  description: 'Comfortable Hoodie',
  rating: 4.2,
  availableProperties: [
    ProductProperty(property: 'size'),
    ProductProperty(property: 'color'),
    ProductProperty(property: 'material'),
  ],
  variations: [
    ProductVariation(
      ID: 'T1',
      variationID: '201',
      price: 31.99,
      productVariantImagesURLs: ['assets/images/blue_hoodie1.jpg', 'assets/images/blue_hoodie2.jpg'],
      productPropertiesValues: [
        ProductPropertyandValue(property: 'size', value: 'M'),
        ProductPropertyandValue(property: 'color', value: 'blue'),
        ProductPropertyandValue(property: 'material', value: 'cotton'),
      ],
    ),
    ProductVariation(
      ID: 'T1',
      variationID: '202',
      price: 24.99,
      productVariantImagesURLs: ['assets/images/red_hoodie1.jpg', 'assets/images/red_hoodie1.png'],
      productPropertiesValues: [
        ProductPropertyandValue(property: 'size', value: 'M'),
        ProductPropertyandValue(property: 'color', value: 'red'),
        ProductPropertyandValue(property: 'material', value: 'cotton'),
      ],
    ),
    ProductVariation(
      ID: 'T1',
      variationID: '203',
      price: 27.99,
      productVariantImagesURLs: ['assets/images/blue_hoodie1.jpg', 'assets/images/blue_hoodie2.jpg'],
      productPropertiesValues: [
        ProductPropertyandValue(property: 'size', value: 'M'),
        ProductPropertyandValue(property: 'color', value: 'blue'),
        ProductPropertyandValue(property: 'material', value: 'polyester'),
      ],
    ),
  ],
);

// ! Product 2
Product p2 = Product(
  ID: 'T2',
  name: 'Green Sweater',
  description: 'Warm wool sweater for winter',
  rating: 4.5,
  availableProperties: [
    ProductProperty(property: 'size'),
    ProductProperty(property: 'color'),
    ProductProperty(property: 'material'),
  ],
  variations: [
    ProductVariation(
      ID: 'T2',
      variationID: '301',
      price: 79.99,
      productVariantImagesURLs: ['assets/images/green_sweater1.jpg', 'assets/images/green_sweater2.png'],
      productPropertiesValues: [
        ProductPropertyandValue(property: 'size', value: 'L'),
        ProductPropertyandValue(property: 'color', value: 'green'),
        ProductPropertyandValue(property: 'material', value: 'wool'),
      ],
    ),
    ProductVariation(
      ID: 'T2',
      variationID: '302',
      price: 59.99,
      productVariantImagesURLs: ['assets/images/green_sweater1.jpg', 'assets/images/green_sweater2.png'],
      productPropertiesValues: [
        ProductPropertyandValue(property: 'size', value: 'M'),
        ProductPropertyandValue(property: 'color', value: 'green'),
        ProductPropertyandValue(property: 'material', value: 'wool'),
      ],
    ),
    ProductVariation(
      ID: 'T2',
      variationID: '302',
      price: 44.99,
      productVariantImagesURLs: ['assets/images/green_sweater1.jpg', 'assets/images/green_sweater2.png'],
      productPropertiesValues: [
        ProductPropertyandValue(property: 'size', value: 'M'),
        ProductPropertyandValue(property: 'color', value: 'green'),
        ProductPropertyandValue(property: 'material', value: 'cotton'),
      ],
    ),
    ProductVariation(
      ID: 'T2',
      variationID: '303',
      price: 39.99,
      productVariantImagesURLs: ['assets/images/black_sweater1.jpg', 'assets/images/black_sweater2.jpg'],
      productPropertiesValues: [
        ProductPropertyandValue(property: 'size', value: 'M'),
        ProductPropertyandValue(property: 'color', value: 'black'),
        ProductPropertyandValue(property: 'material', value: 'cotton'),
      ],
    ),
    ProductVariation(
      ID: 'T2',
      variationID: '303',
      price: 49.99,
      productVariantImagesURLs: ['assets/images/black_sweater1.jpg', 'assets/images/black_sweater2.jpg'],
      productPropertiesValues: [
        ProductPropertyandValue(property: 'size', value: 'L'),
        ProductPropertyandValue(property: 'color', value: 'black'),
        ProductPropertyandValue(property: 'material', value: 'wool'),
      ],
    ),
  ],
);

List<Product> products = [p1, p2];
List<ProductVariation> defaultVariations = [p1.variations[0], p2.variations[0]];

// List<Product> products = [
//   Product(
//     ID: 'T3', name: 'Transparent Hoodie', imageURL: 'assets/images/brown_hoodie2.jpeg',
//     description: 'Tells the time', price: 49.99, rating: 5.0,
//     productSize: AvailableSizes.M, availableSizes: [AvailableSizes.M, AvailableSizes.L],
//   ),
//   Product(
//     ID: 'T3', name: 'Transparent Hoodie', imageURL: 'assets/images/brown_hoodie2.jpeg',
//     description: 'Tells the time', price: 299.99, rating: 5.0,
//     productSize: AvailableSizes.L, availableSizes: [AvailableSizes.M, AvailableSizes.L],
//   ),
//   Product(
//     ID: 'T1', name: 'Blue Hoodie', imageURL: 'assets/images/blue_hoodie1.jpg',
//     description: 'Comfortable cotton t-shirt', price: 19.99, rating: 4.2,
//     productSize: AvailableSizes.M, availableSizes: [AvailableSizes.M, AvailableSizes.L],
//     productColor: Colors.blue, availableColors: [Colors.blue, Colors.red],
//   ),
//   Product(
//     ID: 'T1', name: 'Red Hoodie', imageURL: 'assets/images/red_hoodie1.jpg',
//     description: 'Comfortable cotton t-shirt', price: 19.99, rating: 4.2,
//     productSize: AvailableSizes.M, availableSizes: [AvailableSizes.M, AvailableSizes.L],
//     productColor: Colors.red, availableColors: [Colors.blue, Colors.red],
//   ),
//   Product(
//     ID: 'T1', name: 'Blue Hoodie', imageURL: 'assets/images/blue_hoodie1.jpg',
//     description: 'Comfortable Hoodie', price: 24.99, rating: 4.2,
//     productSize: AvailableSizes.L, availableSizes: [AvailableSizes.M, AvailableSizes.L],
//     productColor: Colors.blue, availableColors: [Colors.blue, Colors.red],
//   ),
//   Product(
//     ID: 'T1', name: 'Red Hoodie', imageURL: 'assets/images/red_hoodie1.jpg',
//     description: 'Comfortable Hoodie', price: 27.99, rating: 4.2,
//     productSize: AvailableSizes.L, availableSizes: [AvailableSizes.M, AvailableSizes.L],
//     productColor: Colors.red, availableColors: [Colors.blue, Colors.red],
//   ),
//   Product(
//     ID: 'T2', name: 'Green Sweater', imageURL: 'assets/images/green_sweater1.jpg',
//     description: 'Warm wool sweater for winter', price: 29.99, rating: 4.5,
//     productSize: AvailableSizes.M, availableSizes: [AvailableSizes.M, AvailableSizes.XL],
//     productColor: Colors.green, availableColors: [Colors.green, Colors.black],
//   ),
//   Product(
//     ID: 'T2', name: 'Green Sweater', imageURL: 'assets/images/green_sweater1.jpg',
//     description: 'Warm wool sweater for winter', price: 49.99, rating: 4.5,
//     productSize: AvailableSizes.XL, availableSizes: [AvailableSizes.M, AvailableSizes.XL],
//     productColor: Colors.green, availableColors: [Colors.green, Colors.black],
//   ),
//   Product(
//     ID: 'T2', name: 'Black Sweater', imageURL: 'assets/images/black_sweater1.jpg',
//     description: 'Warm wool sweater for winter', price: 29.99, rating: 4.5,
//     productSize: AvailableSizes.M, availableSizes: [AvailableSizes.M, AvailableSizes.XL],
//     productColor: Colors.black, availableColors: [Colors.green, Colors.black],
//   ),
//   Product(
//     ID: 'T2', name: 'Black Sweater', imageURL: 'assets/images/black_sweater1.jpg',
//     description: 'Warm wool sweater for winter', price: 49.99, rating: 4.5,
//     productSize: AvailableSizes.XL, availableSizes: [AvailableSizes.M, AvailableSizes.XL],
//     productColor: Colors.black, availableColors: [Colors.green, Colors.black],
//   ),
//   Product(
//     ID: 'B1', name: 'Blue Jeans', imageURL: 'assets/images/blue_jeans1.jpg',
//     description: 'Classic denim jeans', price: 39.99, rating: 4.0,
//     // productSize: AvailableSizes.M, availableSizes: [AvailableSizes.M],
//     productColor: Colors.blue, availableColors: [Colors.blue, Colors.black],
//   ),
//   Product(
//     ID: 'B1', name: 'Black Jeans', imageURL: 'assets/images/black_jeans1.jpg',
//     description: 'Classic denim jeans', price: 49.99, rating: 4.0,
//     // productSize: AvailableSizes.M, availableSizes: [AvailableSizes.M],
//     productColor: Colors.black, availableColors: [Colors.blue, Colors.black],
//   ),
//   // Product(
//   //   ID: 'B1', name: 'Blue Jeans', imageURL: 'assets/images/blue_jeans1.jpg',
//   //   description: 'Classic denim jeans', price: 59.99, rating: 4.0,
//   //   productSize: AvailableSizes.M, availableSizes: [AvailableSizes.S, AvailableSizes.M],
//   //   productColor: Colors.blue, availableColors: [Colors.blue, Colors.black],
//   // ),
//   // Product(
//   //   ID: 'B1', name: 'Black Jeans', imageURL: 'assets/images/black_jeans1.jpg',
//   //   description: 'Classic denim jeans', price: 59.99, rating: 4.0,
//   //   productSize: AvailableSizes.M, availableSizes: [AvailableSizes.S, AvailableSizes.M],
//   //   productColor: Colors.black, availableColors: [Colors.blue, Colors.black],
//   // ),
//   Product(
//     ID: 'S1', name: 'Black Shoes', imageURL: 'assets/images/black_shoe1.jpg',
//     description: 'Amazing Shoes', price: 49.99, rating: 5.0,
//     productSize: AvailableSizes.M, availableSizes: [AvailableSizes.M],
//     productColor: Colors.black, availableColors: [Colors.black, Colors.red],
//   ),
//   Product(
//     ID: 'S1', name: 'Red Shoes', imageURL: 'assets/images/red_shoe1.jpg',
//     description: 'Amazing Shoes', price: 49.99, rating: 5.0,
//     productSize: AvailableSizes.S, availableSizes: [AvailableSizes.S, AvailableSizes.M],
//     productColor: Colors.red, availableColors: [Colors.red],
//   ),
//   Product(
//     ID: 'S1', name: 'Red Shoes', imageURL: 'assets/images/red_shoe1.jpg',
//     description: 'Amazing Shoes', price: 79.99, rating: 5.0,
//     productSize: AvailableSizes.M, availableSizes: [AvailableSizes.S, AvailableSizes.M],
//     productColor: Colors.red, availableColors: [Colors.black, Colors.red],
//   ),
//   Product(
//     ID: 'A1', name: 'White Watch', imageURL: 'assets/images/white_watch1.jpg',
//     description: 'Tells the time', price: 49.99, rating: 5.0,
//     productSize: AvailableSizes.M, availableSizes: [AvailableSizes.M],
//     productColor: Colors.white, availableColors: [ Colors.black, Colors.white],
//   ),
//   Product(
//     ID: 'A1', name: 'Black Watch', imageURL: 'assets/images/black_watch1.png',
//     description: 'Tells the time', price: 49.99, rating: 5.0,
//     productSize: AvailableSizes.M, availableSizes: [AvailableSizes.M],
//     productColor: Colors.black, availableColors: [ Colors.black, Colors.white],
//   // Add more products as needed
//   ),
// ];

// List<Product> uniqueProducts = [];
//
// void groupProducts(){
//   print('started FN');
//   for (Product product in products) {
//     bool isUnique = true;
//     for (Product uniqueProduct in uniqueProducts) {
//       if (product.ID == uniqueProduct.ID) {
//         isUnique = false;
//         print('non unique product: \n');
//         product.getProductDetails();
//         break;
//       }
//     }
//     if (isUnique) {
//       uniqueProducts.add(product);
//       print('unique product added: \n');
//       product.getProductDetails();
//     }
//   }
// }