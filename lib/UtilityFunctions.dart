import 'dart:ui';

import 'package:flutter/foundation.dart';
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
  if (kDebugMode) {
    print('searching for color options');
  }
  // Initialize an empty list to store other colors
  List<String> otherColors = [];

  // Iterate through the variations to find matches and add colors to the list
  for (ProductVariation variation in variations) {

    String currentVarSize = currentVar.getSizeValue();
    String currentVarMaterial = currentVar.getMaterialValue();
    String otherSize = variation.getSizeValue();
    String otherMaterial = variation.getMaterialValue();

    // if(currentVarSize == otherSize && currentVarMaterial == otherMaterial && !otherColors.contains(variation.getColorValue())){
    if(!otherColors.contains(variation.getColorValue())){
      // hasMatchingSize = true;
      // hasMatchingMaterial = true;
      otherColors.add(variation.getColorValue());
    }

  }
  // print other colors (Debug Mode)
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

  if (kDebugMode) {
    print('searching for size options');
  }

  List<String> otherSizes = [];

  // Iterate through the variations to find matches and add colors to the list
  for (ProductVariation variation in variations) {

    String currentVarColor = currentVar.getColorValue();
    String currentVarMaterial = currentVar.getMaterialValue();
    String otherColor = variation.getColorValue();
    String otherMaterial = variation.getMaterialValue();

    if(currentVarColor == otherColor && currentVarMaterial == otherMaterial && !otherSizes.contains(variation.getSizeValue())){
      // hasMatchingSize = true;
      // hasMatchingMaterial = true;
      otherSizes.add(variation.getSizeValue());
    }

  }
  // print other colors (Debug Mode)
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

  if (kDebugMode) {
    print('searching for material options');
  }

  List<String> otherMaterials = [];

  // Iterate through the variations to find matches and add colors to the list
  for (ProductVariation variation in variations) {

    String currentVarColor = currentVar.getColorValue();
    String currentVarSize = currentVar.getSizeValue();
    String otherColor = variation.getColorValue();
    String otherSize = variation.getSizeValue();

    if(currentVarColor == otherColor && currentVarSize == otherSize && !otherMaterials.contains(variation.getMaterialValue())){
      // hasMatchingSize = true;
      // hasMatchingMaterial = true;
      otherMaterials.add(variation.getMaterialValue());
    }

  }

  // print other materials (Debug Mode)
  if (kDebugMode) {
    print('Other materials:');
    for (String material in otherMaterials) {
      print(material);
    }
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
