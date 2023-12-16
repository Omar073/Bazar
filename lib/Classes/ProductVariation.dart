import 'package:flutter/foundation.dart';

import 'ProductProperty.dart';

class ProductVariation{
  String ID;
  String variationID;
  double price;
  List<String> productVariantImagesURLs;
  List<ProductProperty> productPropertiesValues;

  ProductVariation({
    required this.ID,
    required this.variationID,
    required this.price,
    required this.productVariantImagesURLs,
    required this.productPropertiesValues,
  });

  void getVariationDetails() {
    if (kDebugMode) {
      print('Product ID: $ID');
      print('Variation ID: $variationID');
      print('Product Price: $price');
      print('Product Variant Images URLs: $productVariantImagesURLs');
      print('Product Properties:');
    }

    for (ProductProperty productProperty in productPropertiesValues) {
      if (kDebugMode) {
        print('Property: ${productProperty.property}, Value: ${productProperty.value}');
      }
    }
  }
}