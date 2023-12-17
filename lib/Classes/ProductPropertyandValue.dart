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
}