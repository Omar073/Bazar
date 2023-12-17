import 'package:flutter/foundation.dart';

import 'ProductProperty.dart';
import 'ProductPropertyandValue.dart';

class ProductVariation{
  String ID;
  String variationID;
  double price;
  List<String> productVariantImagesURLs;
  List<ProductPropertyandValue> productPropertiesValues; // each property and it's value of a single variation

  ProductVariation({
    required this.ID,
    required this.variationID,
    required this.price,
    required this.productVariantImagesURLs,
    required this.productPropertiesValues,
  });

  void printVariationDetails(){
    if (kDebugMode) {
      print('Product ID: $ID');
      print('Variation ID: $variationID');
      print('Product Price: $price');
      print('Product Variant Images URLs: $productVariantImagesURLs');
      print('Product Properties:');
      printVariationPropertiesValues();
    }
  }

  void printVariationPropertiesValues() {
    for (ProductPropertyandValue productProperty in productPropertiesValues) {
      if (kDebugMode) {
        print('Property: ${productProperty.property}, Value: ${productProperty.value}');
      }
    }
  }
}