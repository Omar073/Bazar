import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'Classes/ProductProperty.dart';
import 'Classes/ProductPropertyandValue.dart';
import 'Classes/ProductVariation.dart';

// Color getColorFromHex(String hexColor) {
//   final int hexValue = int.parse(hexColor.substring(2), radix: 16);
//   return Color(hexValue | 0xFF0000);
// }

Color getColorFromHex(String hexColor) {
  hexColor = hexColor.replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF$hexColor";
  }
  return Color(int.parse(hexColor, radix: 16));
}

List<String> getOtherColors(
    List<ProductVariation> variations, ProductVariation currentVar) {
  debugPrint('searching for color options');
  // Initialize an empty list to store other colors
  List<String> otherColors = [];
  // display no of variations
  // debugPrint('no of variations: ${variations.length}\n');
  // display id of variations
  // for (ProductVariation variation in variations) {
  //   debugPrint('variation id: ${variation.id}');
  // }

  // Iterate through the variations to find matches and add colors to the list
  for (ProductVariation variation in variations) {
    debugPrint('\ncurrent variation id: ${variation.id}');
    debugPrint('\ncurrentVar properties:');
    String currentVarSize = currentVar.getSizeValue(variation);
    String currentVarMaterial = currentVar.getMaterialValue(variation);
    debugPrint('other properties:');
    String otherSize = variation.getSizeValue(variation);
    String otherMaterial = variation.getMaterialValue(variation);

    debugPrint('CURRENT COLOR VALUE: ${currentVar.getColorValue(variation)}');

    if (currentVarSize == otherSize &&
        currentVarMaterial == otherMaterial &&
        !otherColors.contains(variation.getColorValue(variation))) {
      // hasMatchingSize = true;
      // hasMatchingMaterial = true;
      debugPrint('2');
      otherColors.add(variation.getColorValue(variation));
      //debugPrint other colors after variation variation id
      debugPrint('other colors after variation id: ${variation.id}:');
      for (String color in otherColors) {
        debugPrint(color);
      }
    }
  }
  debugPrint('Other colors:');
  for (String color in otherColors) {
    debugPrint(color);
  }

  return otherColors;
}

List<String> getOtherSizes(
    List<ProductVariation> variations, ProductVariation currentVar) {
  debugPrint('searching for size options');

  List<String> otherSizes = [];

  // Iterate through the variations to find matches and add colors to the list
  for (ProductVariation variation in variations) {
    String currentVarColor = currentVar.getColorValue(variation);
    String currentVarMaterial = currentVar.getMaterialValue(variation);
    String otherColor = variation.getColorValue(variation);
    String otherMaterial = variation.getMaterialValue(variation);

    if (currentVarColor == otherColor &&
        currentVarMaterial == otherMaterial &&
        !otherSizes.contains(variation.getSizeValue(variation))) {
      // hasMatchingSize = true;
      // hasMatchingMaterial = true;
      otherSizes.add(variation.getSizeValue(variation));
    }
  }
  debugPrint('Other sizes:');
  for (String size in otherSizes) {
    debugPrint(size);
  }

  return otherSizes;
}

List<String> getOtherMaterials(
    List<ProductVariation> variations, ProductVariation currentVar) {
  debugPrint('searching for material options');

  List<String> otherMaterials = [];

  // Iterate through the variations to find matches and add colors to the list
  for (ProductVariation variation in variations) {
    debugPrint('\ncurrent variation id: ${variation.id}');
    debugPrint('\ncurrentVar properties:');
    String currentVarColor = currentVar.getColorValue(variation);
    String currentVarSize = currentVar.getSizeValue(variation);
    debugPrint('\nother properties:');
    String otherColor = variation.getColorValue(variation);
    String otherSize = variation.getSizeValue(variation);

    debugPrint('\nCURRENT MATERIAL VALUE: ${currentVar.getMaterialValue(variation)}, Price: ${currentVar.price}');

    if (currentVarColor == otherColor &&
        currentVarSize == otherSize &&
        !otherMaterials.contains(variation.getMaterialValue(variation))) {
      // hasMatchingSize = true;
      // hasMatchingMaterial = true;
      debugPrint('2: new material added');
      otherMaterials.add(variation.getMaterialValue(variation));
      debugPrint('other materials after variation id: ${variation.id}:');
      for (String material in otherMaterials) {
        debugPrint(material);
      }
    }
  }

  debugPrint('Other materials:');
  for (String material in otherMaterials) {
    debugPrint(material);
  }

  return otherMaterials;
}

bool haveSameProperties(
    List<ProductPropertyandValue> list1, List<ProductPropertyandValue> list2) {
  // Check if the lengths are equal
  if (list1.length != list2.length) {
    return false;
  }

  // Sort the lists to ensure the order doesn't affect the comparison
  list1.sort((a, b) => a.property.compareTo(b.property));
  list2.sort((a, b) => a.property.compareTo(b.property));

  // Compare each element in the lists
  for (int i = 0; i < list1.length; i++) {
    if (list1[i].property != list2[i].property ||
        list1[i].value != list2[i].value) {
      return false;
    }
  }

  // If all elements are equal, return true
  return true;
}

List<ProductProperty> getProductProperties(List<ProductVariation> variations) {
  debugPrint("\nentered getProductProperties");
  // Initialize an empty list to store properties
  List<String> availablePropertiesString = [];

  // Iterate through the variations to find matches and add colors to the list
  //TODO: in the future check if you need to loop on all variations or is the first one enough
  for (ProductVariation variation in variations) {
    for (ProductPropertyandValue PropnVal
    in variation.productPropertiesValues) {
      if (!availablePropertiesString.contains(PropnVal.property)) {
        availablePropertiesString.add(PropnVal.property);
      }
    }
  }

  debugPrint('Available Properties:');
  for (String property in availablePropertiesString) {
    debugPrint(property);
  }

  // Initialize an empty list to store properties
  List<ProductProperty> availableProperties = [];
  for (String element in availablePropertiesString) {
    availableProperties.add(ProductProperty(property: element));
  }

  debugPrint('Properties:');
  for (ProductProperty productProperty in availableProperties) {
    debugPrint(productProperty.property);
  }
  return availableProperties;
}