import 'package:flutter/foundation.dart';
import 'Classes/ProductVariation.dart';

// List<String> getOtherColors(List<ProductVariation> variations, ProductVariation currentVar) {
//   final currentColor = currentVar.productPropertiesValues
//       .firstWhere((propertyValue) => propertyValue.property == 'color')
//       .value;
//
//   final otherColors = variations
//       .where((variation) =>
//       variation.productPropertiesValues.any((propertyValue) =>
//       propertyValue.property == 'color' &&
//           propertyValue.value != currentColor))
//       .map((variation) =>
//   variation.productPropertiesValues
//       .firstWhere((propertyValue) => propertyValue.property == 'color')
//       .value)
//       .toSet()
//       .toList();
//
//   // Print found colors
//   if (kDebugMode) {
//     print('Other colors:');
//     for (String color in otherColors) {
//       print(color);
//     }
//   }
//
//   return otherColors;
// }

List<String> getOtherColors(
    List<ProductVariation> variations, ProductVariation currentVar) {
  final currentColor = currentVar.productPropertiesValues
      .firstWhere((propertyValue) => propertyValue.property == 'color')
      .value;
  final currentMaterial = currentVar.productPropertiesValues
      .firstWhere((propertyValue) => propertyValue.property == 'material')
      .value;
  final currentSize = currentVar.productPropertiesValues
      .firstWhere((propertyValue) => propertyValue.property == 'size')
      .value;

  final otherColors = variations
      .where((variation) =>
          variation.productPropertiesValues.any((propertyValue) =>
              propertyValue.property == 'color' &&
              propertyValue.value != currentColor) &&
          variation.productPropertiesValues.any((propertyValue) =>
              propertyValue.property == 'material' &&
              propertyValue.value == currentMaterial) &&
          variation.productPropertiesValues.any((propertyValue) =>
              propertyValue.property == 'size' &&
              propertyValue.value == currentSize))
      .map((variation) => variation.productPropertiesValues
          .firstWhere((propertyValue) => propertyValue.property == 'color')
          .value)
      .toSet()
      .toList();

  otherColors.add(currentColor);

  // Print found colors (Debug Mode)
  if (kDebugMode) {
    print('Other colors:');
    for (String color in otherColors) {
      print(color);
    }
  }

  return otherColors;
}

List<String> getOtherSizes(
    List<ProductVariation> variations, ProductVariation currentVar) {
  final currentColor = currentVar.productPropertiesValues
      .firstWhere((propertyValue) => propertyValue.property == 'color')
      .value;
  final currentMaterial = currentVar.productPropertiesValues
      .firstWhere((propertyValue) => propertyValue.property == 'material')
      .value;

  final otherSizes = variations
      .where((variation) =>
          variation.productPropertiesValues.any((propertyValue) =>
              propertyValue.property == 'color' &&
              propertyValue.value == currentColor) &&
          variation.productPropertiesValues.any((propertyValue) =>
              propertyValue.property == 'material' &&
              propertyValue.value == currentMaterial &&
              variation.productPropertiesValues
                      .firstWhere(
                          (propertyValue) => propertyValue.property == 'size')
                      .value !=
                  currentVar.productPropertiesValues
                      .firstWhere(
                          (propertyValue) => propertyValue.property == 'size')
                      .value))
      .map((variation) => variation.productPropertiesValues
          .firstWhere((propertyValue) => propertyValue.property == 'size')
          .value)
      .toSet()
      .toList();

  otherSizes.add(currentVar.productPropertiesValues
          .firstWhere((propertyValue) => propertyValue.property == 'size')
          .value);

  // Print found sizes (Debug Mode)
  if (kDebugMode) {
    print('Other sizes:');
    for (String size in otherSizes) {
      print(size);
    }
  }


  return otherSizes;
}

List<String> getOtherMaterials(
    List<ProductVariation> variations, ProductVariation currentVar) {
  final currentColor = currentVar.productPropertiesValues
      .firstWhere((propertyValue) => propertyValue.property == 'color')
      .value;
  final currentSize = currentVar.productPropertiesValues
      .firstWhere((propertyValue) => propertyValue.property == 'size')
      .value;

  final otherMaterials = variations
      .where((variation) =>
          variation.productPropertiesValues.any((propertyValue) =>
              propertyValue.property == 'color' &&
              propertyValue.value == currentColor) &&
          variation.productPropertiesValues.any((propertyValue) =>
              propertyValue.property == 'size' &&
              propertyValue.value == currentSize &&
              variation.productPropertiesValues
                      .firstWhere((propertyValue) =>
                          propertyValue.property == 'material')
                      .value !=
                  currentVar.productPropertiesValues
                      .firstWhere((propertyValue) =>
                          propertyValue.property == 'material')
                      .value))
      .map((variation) => variation.productPropertiesValues
          .firstWhere((propertyValue) => propertyValue.property == 'material')
          .value)
      .toSet()
      .toList();

  otherMaterials.add(currentVar.productPropertiesValues
          .firstWhere((propertyValue) => propertyValue.property == 'material')
          .value);

  // Print found materials (Debug Mode)
  if (kDebugMode) {
    print('Other materials:');
    for (String material in otherMaterials) {
      print(material);
    }
  }

  return otherMaterials;
}
