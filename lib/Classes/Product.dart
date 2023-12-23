import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
import 'package:slash_homepage_test/Classes/ProductVariation.dart';
import 'package:slash_homepage_test/UtilityFunctions.dart';
import 'ProductProperty.dart';
import 'ProductPropertyandValue.dart';

class Product {
  final String? id; // ID that is common between different variations of same product
  final String? name;
  final String? description;
  final int brandId;
  final String? brandName;
  final String? brandLogoUrl;
  final double? rating;
  final List<ProductVariation> variations; //! non nullable
  final List<ProductProperty> availableProperties;  //What properties are offered
                                              // (multiple colors or non, multiple sizes or non, materials)
  //! availableProperties list all possible attributes but is is not necessary that all combination exist in variances

  // Constructor
  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.brandId,
    required this.brandName,
    required this.brandLogoUrl,
    required this.rating,
    required this.variations,
    required this.availableProperties,
  });

  void getProductDetails() {
    if (kDebugMode) {
      print('Product ID: $id');
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
      if (variation.id == variationID) {
        selectedVariation = variation;
        break;
      }
    }

    if (selectedVariation != null) {
      if (kDebugMode) {
        print('Product Variation ID: ${selectedVariation.id}');
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

  ProductVariation? getVariationByPropertiesValues({required List<ProductPropertyandValue> productPropertiesValues}) {
    if (kDebugMode) {
      print('\nsearching for variation with properties: ');
      printPropertyandValue(productPropertiesValues);
    }
    for (ProductVariation variation in variations) {
      // if (variation.productPropertiesValues.isSameProperty(productPropertiesValues)) {
      if (haveSameProperties(variation.productPropertiesValues, productPropertiesValues)) {
        if (kDebugMode) {
          print('variation found: ');
        }
        return variation;
      }
    }
    if (kDebugMode) {
      print('variation not found');
    }
    // return ProductVariation(
    //   ID: '',
    //   variationID: '',
    //   price: null,
    //   productVariantImagesURLs: const[],
    //   productPropertiesValues: const[],
    // );
    return null;
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
  id: 'T1',
  name: 'Hoodie',
  description: 'Comfortable Hoodie',
  brandId: 1,
  brandName: '3antar',
  brandLogoUrl: 'assets/images/logo2.jpg',
  rating: 4.2,
  availableProperties: [
    ProductProperty(property: 'size'),
    ProductProperty(property: 'color'),
    ProductProperty(property: 'material'),
  ],
  variations: [
    ProductVariation(
      id: '101',
      productId: 'T1',
      price: 31.99,
      quantity: 10,
      // inStock is true if quantity > 0
      productVariantImagesURLs: ['assets/images/blue_hoodie1.jpg', 'assets/images/blue_hoodie2.jpg', 'assets/images/blue_hoodie3.jpg'],
      productPropertiesValues: [
        ProductPropertyandValue(property: 'size', value: 'M'),
        ProductPropertyandValue(property: 'color', value: '#008EFF'), // blue
        ProductPropertyandValue(property: 'material', value: 'cotton'),
      ],
    ),
    ProductVariation(
      id: '102',
      productId: 'T1',
      price: 24.99,
      quantity: 10,
      productVariantImagesURLs: ['assets/images/red_hoodie1.jpg', 'assets/images/red_hoodie2.png', 'assets/images/red_hoodie3.jpg'],
      productPropertiesValues: [
        ProductPropertyandValue(property: 'size', value: 'M'),
        ProductPropertyandValue(property: 'color', value: '#FF0000'), // red
        ProductPropertyandValue(property: 'material', value: 'cotton'),
      ],
    ),
    ProductVariation(
      productId: 'T1',
      id: '103',
      price: 27.99,
      quantity: 5,
      productVariantImagesURLs: ['assets/images/blue_hoodie1.jpg', 'assets/images/blue_hoodie2.jpg', 'assets/images/blue_hoodie3.jpg'],
      productPropertiesValues: [
        ProductPropertyandValue(property: 'size', value: 'M'),
        ProductPropertyandValue(property: 'color', value: '#008EFF'), // blue
        ProductPropertyandValue(property: 'material', value: 'polyester'),
      ],
    ),
  ],
);

// ! Product 2
Product p2 = Product(
  id: 'T2',
  name: 'Green Sweater',
  description: 'Warm wool sweater for winter',
  brandId: 1,
  brandName: '3antar',
  brandLogoUrl: 'assets/images/logo2.jpg',
  rating: 4.5,
  availableProperties: [
    ProductProperty(property: 'size'),
    ProductProperty(property: 'color'),
    ProductProperty(property: 'material'),
  ],
  variations: [
    ProductVariation(
      id: '201',
      productId: 'T2',
      price: 79.99,
      quantity: 10,
      productVariantImagesURLs: ['assets/images/green_sweater1.jpg', 'assets/images/green_sweater2.png', 'assets/images/green_sweater3.jpg'],
      productPropertiesValues: [
        ProductPropertyandValue(property: 'size', value: 'L'),
        ProductPropertyandValue(property: 'color', value: '#00AC00'), // green
        ProductPropertyandValue(property: 'material', value: 'wool'),
      ],
    ),
    ProductVariation(
      id: '202',
      productId: 'T2',
      price: 59.99,
      quantity: 20,
      productVariantImagesURLs: ['assets/images/green_sweater1.jpg', 'assets/images/green_sweater2.png', 'assets/images/green_sweater3.jpg'],
      productPropertiesValues: [
        ProductPropertyandValue(property: 'size', value: 'M'),
        ProductPropertyandValue(property: 'color', value: '#00AC00'), // green
        ProductPropertyandValue(property: 'material', value: 'wool'),
      ],
    ),
    ProductVariation(
      id: '203',
      productId: 'T2',
      price: 44.99,
      quantity: 3,
      productVariantImagesURLs: ['assets/images/green_sweater1.jpg', 'assets/images/green_sweater2.png', 'assets/images/green_sweater3.jpg'],
      productPropertiesValues: [
        ProductPropertyandValue(property: 'size', value: 'M'),
        ProductPropertyandValue(property: 'color', value: '#00AC00'), // green
        ProductPropertyandValue(property: 'material', value: 'cotton'),
      ],
    ),
    ProductVariation(
      id: '204',
      productId: 'T2',
      price: 39.99,
      quantity: 10,
      productVariantImagesURLs: ['assets/images/black_sweater1.jpg', 'assets/images/black_sweater2.jpg'],
      productPropertiesValues: [
        ProductPropertyandValue(property: 'size', value: 'M'),
        ProductPropertyandValue(property: 'color', value: '#000000'), // black
        ProductPropertyandValue(property: 'material', value: 'cotton'),
      ],
    ),
    ProductVariation(
      id: '205',
      productId: 'T2',
      price: 49.99,
      quantity: 10,
      productVariantImagesURLs: ['assets/images/black_sweater1.jpg', 'assets/images/black_sweater2.jpg'],
      productPropertiesValues: [
        ProductPropertyandValue(property: 'size', value: 'L'),
        ProductPropertyandValue(property: 'color', value: '#000000'), // black
        ProductPropertyandValue(property: 'material', value: 'wool'),
      ],
    ),
  ],
);

//! Product 3
Product p3 = Product(
  id: 'S3',
  name: 'Shoes',
  description: 'looking good',
  brandId: 2,
  brandName: 'ibuzz',
  brandLogoUrl: 'assets/images/logo.png',
  rating: 5.0,
  availableProperties: [
    ProductProperty(property: 'size'),
    ProductProperty(property: 'color'),
    // ProductProperty(property: 'material'),
  ],
  variations: [
    ProductVariation(
      id: '301',
      productId: 'S3',
      price: 49.99,
      quantity: 10,
      productVariantImagesURLs: ['assets/images/red_shoe1.jpg', 'assets/images/red_shoe1.jpg'],
      productPropertiesValues: [
        ProductPropertyandValue(property: 'size', value: 'M'),
        ProductPropertyandValue(property: 'color', value: '#FF0000'), // red
        // ProductPropertyandValue(property: 'material', value: 'leather'),
      ],
    ),
    ProductVariation(
      id: '302',
      productId: 'S3',
      price: 79.99,
      quantity: 10,
      productVariantImagesURLs: ['assets/images/red_shoe1.jpg', 'assets/images/red_shoe1.jpg'],
      productPropertiesValues: [
        ProductPropertyandValue(property: 'size', value: 'L'),
        ProductPropertyandValue(property: 'color', value: '#FF0000'), // red
        // ProductPropertyandValue(property: 'material', value: 'leather'),
      ],
    ),
    ProductVariation(
      id: '303',
      productId: 'S3',
      price: 79.99,
      quantity: 10,
      productVariantImagesURLs: ['assets/images/grey_shoe1.png', 'assets/images/grey_shoe2.jpg'],
      productPropertiesValues: [
        ProductPropertyandValue(property: 'size', value: 'M'),
        ProductPropertyandValue(property: 'color', value: '#928080'), // grey
        // grey = #808080
        // ProductPropertyandValue(property: 'material', value: 'leather'),
      ],
    ),
  ],
);

//! Product 4
Product p4 = Product(
  id: 'A1',
  name: 'Watch',
  description: 'Tells the time',
  brandId: 2,
  brandName: 'ibuzz',
  brandLogoUrl: 'assets/images/logo.png',
  rating: 4.5,
  availableProperties: [
    // ProductProperty(property: 'size'),
    ProductProperty(property: 'color'),
    ProductProperty(property: 'material'),
  ],
  variations: [
    ProductVariation(
      id: '401',
      productId: 'A1',
      price: 59.99,
      quantity: 10,
      productVariantImagesURLs: ['assets/images/red_watch1.jpg', 'assets/images/red_watch2.jpg'],
      productPropertiesValues: [
        // ProductPropertyandValue(property: 'size', value: 'M'),
        ProductPropertyandValue(property: 'color', value: '#FF0000'), // red
        ProductPropertyandValue(property: 'material', value: 'leather'),
      ],
    ),
    ProductVariation(
      id: '402',
      productId: 'A1',
      price: 79.99,
      quantity: 10,
      productVariantImagesURLs: ['assets/images/white_watch1.jpg', 'assets/images/white_watch2.jpg'],
      productPropertiesValues: [
        // ProductPropertyandValue(property: 'size', value: 'L'),
        ProductPropertyandValue(property: 'color', value: '#FFFFFF'), // white
        ProductPropertyandValue(property: 'material', value: 'leather'),
      ],
    ),
    ProductVariation(
      id: '403',
      productId: 'A1',
      price: 79.99,
      quantity: 10,
      productVariantImagesURLs: ['assets/images/black_watch1.png', 'assets/images/black_watch2.jpg'],
      productPropertiesValues: [
        // ProductPropertyandValue(property: 'size', value: 'M'),
        ProductPropertyandValue(property: 'color', value: '#000000'), // black
        ProductPropertyandValue(property: 'material', value: 'metal'),
      ],
    ),
    // ProductVariation(
    //   ID: 'A1',
    //   variationID: '404',
    //   price: 99.99,
    //   productVariantImagesURLs: ['assets/images/black_watch1.png', 'assets/images/black_watch2.jpg'],
    //   productPropertiesValues: [
    //     // ProductPropertyandValue(property: 'size', value: 'M'),
    //     ProductPropertyandValue(property: 'color', value: '#000000'),
    //     ProductPropertyandValue(property: 'material', value: 'leather'),
    //   ],
    // ),
  ],
);

List<Product> products = [p1, p2, p3, p4];
List<ProductVariation> defaultVariations = [p1.variations[0], p2.variations[0], p3.variations[0], p4.variations[0]];
