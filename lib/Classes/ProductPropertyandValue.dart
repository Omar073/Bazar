import 'package:flutter/foundation.dart';
import 'package:slash_homepage_test/Classes/ProductProperty.dart';

class ProductPropertyandValue {
  // final ProductProperty property;
  final String property;
  final String value;

  ProductPropertyandValue({
    required this.property,
    required this.value,
  });

  factory ProductPropertyandValue.fromJson(Map<String, dynamic> json) {
    return ProductPropertyandValue(
      property: json['property'],
      value: json['value'],
    );
  }
}

  void printPropertyandValue(List<ProductPropertyandValue> productPropertiesValues){
    for (ProductPropertyandValue productProperty in productPropertiesValues) {
      if (kDebugMode) {
        print('Property: ${productProperty.property}, Value: ${productProperty.value}');
      }
    }
  }
