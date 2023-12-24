import 'package:flutter/foundation.dart';
import '../Providers/ProductsListProvider.dart';
import 'Product.dart';
import 'ProductProperty.dart';
import 'ProductPropertyandValue.dart';

class ProductVariation {
  final int id;
  final int productId;
  final int? price;
  final int quantity;
  final bool? inStock;
  final List<String>? productVariantImagesURLs;
  final List<ProductPropertyandValue> productPropertiesValues; // each property and it's value of a single variation

  ProductVariation({
    required this.id,
    required this.productId,
    this.price,
    required this.quantity,
    this.inStock,
    this.productVariantImagesURLs,
    List<ProductPropertyandValue>? productPropertiesValues,
  }) : productPropertiesValues = productPropertiesValues ?? [];

  // ProductVariation({
  //   required this.productId,
  //   required this.id,
  //   required this.price,
  //   required this.quantity,
  //   required this.productVariantImagesURLs,
  //   required this.productPropertiesValues,
  // })  : inStock = quantity > 0;

  factory ProductVariation.fromJson(Map<String, dynamic> json) {
    return ProductVariation(
      id: json['id'],
      productId: json['productId'],
      price: json['price'],
      quantity: json['quantity'],
      inStock: json['inStock'],
      productVariantImagesURLs:
      (json['productVariantImagesURLs'] as List<dynamic>?)?.cast<String>(),
      productPropertiesValues: (json['productPropertiesValues'] as List<dynamic>?)
          ?.map((v) => ProductPropertyandValue.fromJson(v))
          .toList() ?? [],
    );
  }

  // factory ProductVariation.fromJson(Map<String, dynamic> json) {
  //   final imagesData = json['ProductVarientImages'];
  //
  //   return ProductVariation(
  //     id: json['id'].toString(),
  //     productId: json['product_id'].toString(),
  //     price: json['price']?.toDouble(),
  //     quantity: json['quantity'],
  //     inStock: json['quantity'] >
  //         0, // Check if quantity is greater than 0 for inStock
  //     productVariantImagesURLs: imagesData != null
  //         ? List<String>.from(imagesData.map((image) => image['image_path']))
  //         : [],
  //     productPropertiesValues: json['ProductPropertiesValues'] != null
  //         ? List<ProductPropertyandValue>.from(
  //             json['ProductPropertiesValues'].map(
  //                 (property) => ProductPropertyandValue.fromJson(property)),
  //           )
  //         : [],
  //   );
  // }

  // TODO: create the rest of the setters and getters

  void debugPrintVariationDetails() {
    if (kDebugMode) {
      debugPrint('Product ID: $productId');
      debugPrint('Variation ID: $id');
      debugPrint('Product Price: $price');
      debugPrint('Product Variant Images URLs: $productVariantImagesURLs');
      debugPrint('Product Properties:');
      debugPrintVariationPropertiesValues();
    }
  }

  Product? getProduct() {
    List<Product> products = ProductsListProvider().products;
    for (Product p in products) {
      if (p.id == productId) {
        return p;
      }
    }
    return null;
  }

  void debugPrintVariationPropertiesValues() {
    for (ProductPropertyandValue productProperty in productPropertiesValues) {
      if (kDebugMode) {
        debugPrint(
            'Property: ${productProperty.property}, Value: ${productProperty.value}');
      }
    }
  }

  String? getName() {
    List<Product> products = ProductsListProvider().products;
    // debugPrint('Searching for the name of product with ID: $ID');
    for (Product p in products) {
      p.displayProductInfo(p);
      if (p.id == productId) {
        debugPrint('ID found');
        debugPrint('Name: ${p.name}');
        return p.name;
      }
    }
    debugPrint('ID not found getName()');
    return null; // Return null if the ID is not found
  }

  String? getDescription() {
    List<Product> products = ProductsListProvider().products;
    // debugPrint('Searching for the description of product with ID: $ID');
    for (Product p in products) {
      if (p.id == productId) {
        // debugPrint('ID found');
        // debugPrint('Description: ${p.description}');
        return p.description;
      }
    }
    if (kDebugMode) {
      debugPrint('ID not found getDescription()');
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
