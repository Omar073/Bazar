import 'package:flutter/material.dart';
import '../Classes/ProductProperty.dart';
import '../Classes/ProductPropertyandValue.dart';

class ProductPropertiesWidget extends StatelessWidget {
  final List<ProductPropertyandValue> productPropertiesValues;  // each property and it's value of a single variation
  final ProductProperty Property;

  ProductPropertiesWidget({super.key,
    required this.productPropertiesValues,
    required this.Property,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'select the preferred ${Property.property}:',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        buildPropertyOption(Property),
      ],
    );
  }

  Widget buildPropertyOption(ProductProperty property) {
    ProductPropertyandValue? propertyValue =
    getPropertyAndValue(property.property);

    return propertyValue != null
        ? Text('${property.property}: ${propertyValue.value}')
        : Text('${property.property}: N/A');
  }

  ProductPropertyandValue? getPropertyAndValue(String property) {
    for (ProductPropertyandValue propertyValue in productPropertiesValues) {
      if (propertyValue.property == property) {
        return propertyValue;
      }
    }
    return null;
  }
}
