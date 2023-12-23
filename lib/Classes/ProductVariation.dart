import 'package:flutter/foundation.dart';

import 'Product.dart';
import 'ProductProperty.dart';
import 'ProductPropertyandValue.dart';

class ProductVariation{
  final String id;
  final String productId;
  final double? price;
  final int quantity;
  final bool inStock;
  final List<String>? productVariantImagesURLs;
  final List<ProductPropertyandValue> productPropertiesValues; // each property and it's value of a single variation

  ProductVariation({
    required this.productId,
    required this.id,
    required this.price,
    required this.quantity,
    required this.productVariantImagesURLs,
    required this.productPropertiesValues,
  })  : inStock = quantity > 0;

  // TODO: create the rest of the setters and getters

  void printVariationDetails(){
    if (kDebugMode) {
      print('Product ID: $productId');
      print('Variation ID: $id');
      print('Product Price: $price');
      print('Product Variant Images URLs: $productVariantImagesURLs');
      print('Product Properties:');
      printVariationPropertiesValues();
    }
  }

  Product? getProduct(){
    for (Product p in products) {
      if (p.id == productId) {
        return p;
      }
    }
    return null;
  }

  void printVariationPropertiesValues() {
    for (ProductPropertyandValue productProperty in productPropertiesValues) {
      if (kDebugMode) {
        print('Property: ${productProperty.property}, Value: ${productProperty.value}');
      }
    }
  }

  String? getName() {
    // print('Searching for the name of product with ID: $ID');
    for (Product p in products) {
      if (p.id == productId) {
        // print('ID found');
        // print('Name: ${p.name}');
        return p.name;
      }
    }
    print('ID not found getName()');
    return null; // Return null if the ID is not found
  }

  String? getDescription() {
    // print('Searching for the description of product with ID: $ID');
    for (Product p in products) {
      if (p.id == productId) {
        // print('ID found');
        // print('Description: ${p.description}');
        return p.description;
      }
    }
    if (kDebugMode) {
      print('ID not found getDescription()');
    }
    return null; // Return null if the ID is not found
  }


  String getSizeValue() {
    for (ProductPropertyandValue propertyValue in productPropertiesValues) {
      if (propertyValue.property == 'size') {
        return propertyValue.value;
      }
    }
    return 'N/A'; // Return a default value if size is not found
    // return null;
  }

  String getColorValue() {
    for (ProductPropertyandValue propertyValue in productPropertiesValues) {
      if (propertyValue.property == 'color') {
        return propertyValue.value;
      }
    }
    return 'N/A'; // Return a default value if color is not found
    // return null;
  }

  String getMaterialValue() {
    for (ProductPropertyandValue propertyValue in productPropertiesValues) {
      if (propertyValue.property == 'material') {
        return propertyValue.value;
      }
    }
    return 'N/A'; // Return a default value if color is not found
    // return null;
  }

  bool isSameProperty(ProductPropertyandValue propertyValue) {
    for (ProductPropertyandValue property in productPropertiesValues) {
      if (property.property == propertyValue.property) {
        return true;
      }
    }
    return false;
  }
}