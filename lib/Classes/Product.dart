import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
import 'package:bazar/Classes/ProductVariation.dart';
import 'package:bazar/UtilityFunctions.dart';
import 'ProductProperty.dart';
import 'ProductPropertyandValue.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product {
  int? _id; // ID that is common between different variations of the same product
  String? _name;
  String? _description;
  int _brandId;
  String? _brandName;
  String? _brandLogoUrl;
  int? _rating;
  List<ProductVariation> _variations; // Non-nullable
  List<ProductProperty> _availableProperties; // What properties are offered

  // Constructor
  Product({
    int? id,
    String? name,
    String? description,
    required int brandId,
    String? brandName,
    String? brandLogoUrl,
    int? rating,
    List<ProductVariation>? variations,
    List<ProductProperty>? availableProperties,
  })  : _id = id,
        _name = name,
        _description = description,
        _brandId = brandId,
        _brandName = brandName,
        _brandLogoUrl = brandLogoUrl,
        _rating = rating,
        _variations = variations ?? [],
        _availableProperties = availableProperties ?? [];

  // Getters
  int? get id => _id;

  String? get name => _name;

  String? get description => _description;

  int get brandId => _brandId;

  String? get brandName => _brandName;

  String? get brandLogoUrl => _brandLogoUrl;

  int? get rating => _rating;

  List<ProductVariation> get variations => _variations;

  List<ProductProperty> get availableProperties => _availableProperties;

  // Setters
  set id(int? value) {
    _id = value;
  }

  set name(String? value) {
    _name = value;
  }

  set description(String? value) {
    _description = value;
  }

  set brandId(int value) {
    _brandId = value;
  }

  set brandName(String? value) {
    _brandName = value;
  }

  set brandLogoUrl(String? value) {
    _brandLogoUrl = value;
  }

  set rating(int? value) {
    _rating = value;
  }

  set variations(List<ProductVariation> value) {
    _variations = value;
  }

  set availableProperties(List<ProductProperty> value) {
    _availableProperties = value;
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      brandId: json['brandId'],
      brandName: json['brandName'],
      brandLogoUrl: json['brandLogoUrl'],
      rating: json['rating'],
      variations: (json['variations'] as List<dynamic>?)
              ?.map((v) => ProductVariation.fromJson(v))
              .toList() ??
          [],
      availableProperties: (json['availableProperties'] as List<dynamic>?)
              ?.map((v) => ProductProperty.fromJson(v))
              .toList() ??
          [],
    );
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
      debugPrint('Product Variation ID: ${selectedVariation.id}');
      debugPrint('Product Variation Price: ${selectedVariation.price}');
      debugPrint(
          'Product Variation Images URLs: ${selectedVariation.productVariantImagesURLs}');
      debugPrint('Product Variation Properties:');

      for (ProductPropertyandValue propertyValue
          in selectedVariation.productPropertiesValues) {
        debugPrint(
            'Property: ${propertyValue.property}, Value: ${propertyValue.value}');
      }
    } else {
      debugPrint('Product Variation not found with ID: $variationID');
    }
  }

  ProductVariation? getVariationByPropertiesValues(
      {required List<ProductPropertyandValue> productPropertiesValues}) {
    debugPrint('\nsearching for variation with properties: ');
    printPropertyandValue(productPropertiesValues);
    for (ProductVariation variation in variations) {
      // if (variation.productPropertiesValues.isSameProperty(productPropertiesValues)) {
      if (haveSameProperties(
          variation.productPropertiesValues, productPropertiesValues)) {
        debugPrint('variation found: ');
        return variation;
      }
    }

    debugPrint('variation not found');

    // return ProductVariation(
    //   ID: '',
    //   variationID: '',
    //   price: null,
    //   productVariantImagesURLs: const[],
    //   productPropertiesValues: const[],
    // );
    return null;
  }

  void displayAvailableProperties() {
    debugPrint('Available Properties for product with ID: $id');
    for (ProductProperty property in availableProperties) {
      debugPrint('Property: ${property.property}');
    }
  }

  bool hasColors() {
    for (ProductProperty property in availableProperties) {
      if (property.property == 'color') {
        return true;
      }
    }
    return false;
  }

  void displayProductInfo() {
    debugPrint('Product ID: ${id ?? 'nullID'}');
    debugPrint('Product Name: ${name ?? 'nullName'}');
    debugPrint('Product Description: ${description ?? 'nullDescription'}');
    debugPrint('Product Brand ID: $brandId');
    debugPrint('Product Brand Name: ${brandName ?? 'nullBrandName'}');
    debugPrint('Product Brand Logo URL: ${brandLogoUrl ?? 'nullBrandLogoURL'}');
    debugPrint('Product Rating: ${rating ?? 'nullRating'}');
    debugPrint('Product Variations: ${variations ?? 'nullVariations'}');
    debugPrint('Product Available Properties: ${availableProperties ?? 'nullAvailableProperties'}');
  }

// // ! Product 1
// Product p1 = Product(
//   id: 'T1',
//   name: 'Hoodie',
//   description: 'Comfortable Hoodie',
//   brandId: 1,
//   brandName: '3antar',
//   brandLogoUrl: 'assets/images/logo2.jpg',
//   rating: 4.2,
//   availableProperties: [
//     ProductProperty(property: 'size'),
//     ProductProperty(property: 'color'),
//     ProductProperty(property: 'material'),
//   ],
//   variations: [
//     ProductVariation(
//       id: '101',
//       productId: 'T1',
//       price: 31.99,
//       quantity: 10,
//       // inStock is true if quantity > 0
//       productVariantImagesURLs: ['assets/images/blue_hoodie1.jpg', 'assets/images/blue_hoodie2.jpg', 'assets/images/blue_hoodie3.jpg'],
//       productPropertiesValues: [
//         ProductPropertyandValue(property: 'size', value: 'M'),
//         ProductPropertyandValue(property: 'color', value: '#008EFF'), // blue
//         ProductPropertyandValue(property: 'material', value: 'cotton'),
//       ],
//     ),
//     ProductVariation(
//       id: '102',
//       productId: 'T1',
//       price: 24.99,
//       quantity: 10,
//       productVariantImagesURLs: ['assets/images/red_hoodie1.jpg', 'assets/images/red_hoodie2.png', 'assets/images/red_hoodie3.jpg'],
//       productPropertiesValues: [
//         ProductPropertyandValue(property: 'size', value: 'M'),
//         ProductPropertyandValue(property: 'color', value: '#FF0000'), // red
//         ProductPropertyandValue(property: 'material', value: 'cotton'),
//       ],
//     ),
//     ProductVariation(
//       productId: 'T1',
//       id: '103',
//       price: 27.99,
//       quantity: 5,
//       productVariantImagesURLs: ['assets/images/blue_hoodie1.jpg', 'assets/images/blue_hoodie2.jpg', 'assets/images/blue_hoodie3.jpg'],
//       productPropertiesValues: [
//         ProductPropertyandValue(property: 'size', value: 'M'),
//         ProductPropertyandValue(property: 'color', value: '#008EFF'), // blue
//         ProductPropertyandValue(property: 'material', value: 'polyester'),
//       ],
//     ),
//   ],
// );
//
// // ! Product 2
// Product p2 = Product(
//   id: 'T2',
//   name: 'Green Sweater',
//   description: 'Warm wool sweater for winter',
//   brandId: 1,
//   brandName: '3antar',
//   brandLogoUrl: 'assets/images/logo2.jpg',
//   rating: 4.5,
//   availableProperties: [
//     ProductProperty(property: 'size'),
//     ProductProperty(property: 'color'),
//     ProductProperty(property: 'material'),
//   ],
//   variations: [
//     ProductVariation(
//       id: '201',
//       productId: 'T2',
//       price: 79.99,
//       quantity: 10,
//       productVariantImagesURLs: ['assets/images/green_sweater1.jpg', 'assets/images/green_sweater2.png', 'assets/images/green_sweater3.jpg'],
//       productPropertiesValues: [
//         ProductPropertyandValue(property: 'size', value: 'L'),
//         ProductPropertyandValue(property: 'color', value: '#00AC00'), // green
//         ProductPropertyandValue(property: 'material', value: 'wool'),
//       ],
//     ),
//     ProductVariation(
//       id: '202',
//       productId: 'T2',
//       price: 59.99,
//       quantity: 20,
//       productVariantImagesURLs: ['assets/images/green_sweater1.jpg', 'assets/images/green_sweater2.png', 'assets/images/green_sweater3.jpg'],
//       productPropertiesValues: [
//         ProductPropertyandValue(property: 'size', value: 'M'),
//         ProductPropertyandValue(property: 'color', value: '#00AC00'), // green
//         ProductPropertyandValue(property: 'material', value: 'wool'),
//       ],
//     ),
//     ProductVariation(
//       id: '203',
//       productId: 'T2',
//       price: 44.99,
//       quantity: 3,
//       productVariantImagesURLs: ['assets/images/green_sweater1.jpg', 'assets/images/green_sweater2.png', 'assets/images/green_sweater3.jpg'],
//       productPropertiesValues: [
//         ProductPropertyandValue(property: 'size', value: 'M'),
//         ProductPropertyandValue(property: 'color', value: '#00AC00'), // green
//         ProductPropertyandValue(property: 'material', value: 'cotton'),
//       ],
//     ),
//     ProductVariation(
//       id: '204',
//       productId: 'T2',
//       price: 39.99,
//       quantity: 10,
//       productVariantImagesURLs: ['assets/images/black_sweater1.jpg', 'assets/images/black_sweater2.jpg'],
//       productPropertiesValues: [
//         ProductPropertyandValue(property: 'size', value: 'M'),
//         ProductPropertyandValue(property: 'color', value: '#000000'), // black
//         ProductPropertyandValue(property: 'material', value: 'cotton'),
//       ],
//     ),
//     ProductVariation(
//       id: '205',
//       productId: 'T2',
//       price: 49.99,
//       quantity: 10,
//       productVariantImagesURLs: ['assets/images/black_sweater1.jpg', 'assets/images/black_sweater2.jpg'],
//       productPropertiesValues: [
//         ProductPropertyandValue(property: 'size', value: 'L'),
//         ProductPropertyandValue(property: 'color', value: '#000000'), // black
//         ProductPropertyandValue(property: 'material', value: 'wool'),
//       ],
//     ),
//   ],
// );
//
// //! Product 3
// Product p3 = Product(
//   id: 'S3',
//   name: 'Shoes',
//   description: 'looking good',
//   brandId: 2,
//   brandName: 'ibuzz',
//   brandLogoUrl: 'assets/images/logo.png',
//   rating: 5.0,
//   availableProperties: [
//     ProductProperty(property: 'size'),
//     ProductProperty(property: 'color'),
//     // ProductProperty(property: 'material'),
//   ],
//   variations: [
//     ProductVariation(
//       id: '301',
//       productId: 'S3',
//       price: 49.99,
//       quantity: 10,
//       productVariantImagesURLs: ['assets/images/red_shoe1.jpg', 'assets/images/red_shoe1.jpg'],
//       productPropertiesValues: [
//         ProductPropertyandValue(property: 'size', value: 'M'),
//         ProductPropertyandValue(property: 'color', value: '#FF0000'), // red
//         // ProductPropertyandValue(property: 'material', value: 'leather'),
//       ],
//     ),
//     ProductVariation(
//       id: '302',
//       productId: 'S3',
//       price: 79.99,
//       quantity: 10,
//       productVariantImagesURLs: ['assets/images/red_shoe1.jpg', 'assets/images/red_shoe1.jpg'],
//       productPropertiesValues: [
//         ProductPropertyandValue(property: 'size', value: 'L'),
//         ProductPropertyandValue(property: 'color', value: '#FF0000'), // red
//         // ProductPropertyandValue(property: 'material', value: 'leather'),
//       ],
//     ),
//     ProductVariation(
//       id: '303',
//       productId: 'S3',
//       price: 79.99,
//       quantity: 10,
//       productVariantImagesURLs: ['assets/images/grey_shoe1.png', 'assets/images/grey_shoe2.jpg'],
//       productPropertiesValues: [
//         ProductPropertyandValue(property: 'size', value: 'M'),
//         ProductPropertyandValue(property: 'color', value: '#928080'), // grey
//         // grey = #808080
//         // ProductPropertyandValue(property: 'material', value: 'leather'),
//       ],
//     ),
//   ],
// );
//
// //! Product 4
// Product p4 = Product(
//   id: 'A1',
//   name: 'Watch',
//   description: 'Tells the time',
//   brandId: 2,
//   brandName: 'ibuzz',
//   brandLogoUrl: 'assets/images/logo.png',
//   rating: 4.5,
//   availableProperties: [
//     // ProductProperty(property: 'size'),
//     ProductProperty(property: 'color'),
//     ProductProperty(property: 'material'),
//   ],
//   variations: [
//     ProductVariation(
//       id: '401',
//       productId: 'A1',
//       price: 59.99,
//       quantity: 10,
//       productVariantImagesURLs: ['assets/images/red_watch1.jpg', 'assets/images/red_watch2.jpg'],
//       productPropertiesValues: [
//         // ProductPropertyandValue(property: 'size', value: 'M'),
//         ProductPropertyandValue(property: 'color', value: '#FF0000'), // red
//         ProductPropertyandValue(property: 'material', value: 'leather'),
//       ],
//     ),
//     ProductVariation(
//       id: '402',
//       productId: 'A1',
//       price: 79.99,
//       quantity: 10,
//       productVariantImagesURLs: ['assets/images/white_watch1.jpg', 'assets/images/white_watch2.jpg'],
//       productPropertiesValues: [
//         // ProductPropertyandValue(property: 'size', value: 'L'),
//         ProductPropertyandValue(property: 'color', value: '#FFFFFF'), // white
//         ProductPropertyandValue(property: 'material', value: 'leather'),
//       ],
//     ),
//     ProductVariation(
//       id: '403',
//       productId: 'A1',
//       price: 79.99,
//       quantity: 10,
//       productVariantImagesURLs: ['assets/images/black_watch1.png', 'assets/images/black_watch2.jpg'],
//       productPropertiesValues: [
//         // ProductPropertyandValue(property: 'size', value: 'M'),
//         ProductPropertyandValue(property: 'color', value: '#000000'), // black
//         ProductPropertyandValue(property: 'material', value: 'metal'),
//       ],
//     ),
//     // ProductVariation(
//     //   ID: 'A1',
//     //   variationID: '404',
//     //   price: 99.99,
//     //   productVariantImagesURLs: ['assets/images/black_watch1.png', 'assets/images/black_watch2.jpg'],
//     //   productPropertiesValues: [
//     //     // ProductPropertyandValue(property: 'size', value: 'M'),
//     //     ProductPropertyandValue(property: 'color', value: '#000000'),
//     //     ProductPropertyandValue(property: 'material', value: 'leather'),
//     //   ],
//     // ),
//   ],
// );

// List<Product> products = [p1, p2, p3, p4];
//   List<Product> products = [];
// // List<ProductVariation> defaultVariations = [p1.variations[0], p2.variations[0], p3.variations[0], p4.variations[0]];
//   List<ProductVariation> defaultVariations = (json['ProductVariations'] as List)
//       .map((variationJson) => ProductVariation.fromJson(variationJson))
//       .toList();
}
