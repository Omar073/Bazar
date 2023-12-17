import 'package:flutter/foundation.dart';
import 'package:slash_homepage_test/Classes/ProductProperty.dart';

class ProductPropertyandValue{
  // ProductProperty property; // property may be: color, size, material
  String property; // property may be: color, size, material
  String value;   //if property is color, value may be: #008000(hex for Green)
  //if property is size, value may be: XL

  ProductPropertyandValue({
    required this.property,
    required this.value,
  });

  // bool isSameProperty(ProductPropertyandValue propertyValue) {
  //   for (ProductPropertyandValue property in productPropertiesValues) {
  //     if (property.property == propertyValue.property) {
  //       return true;
  //     }
  //   }
  //   return false;
  // }

}
  void printPropertyandValue(List<ProductPropertyandValue> productPropertiesValues){
    for (ProductPropertyandValue productProperty in productPropertiesValues) {
      if (kDebugMode) {
        print('Property: ${productProperty.property}, Value: ${productProperty.value}');
      }
    }
  }
