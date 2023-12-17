import 'package:flutter/foundation.dart';
import 'Classes/ProductPropertyandValue.dart';
import 'Classes/ProductVariation.dart';
import 'dart:collection'; // Import the dart:collection library


//TODO: replace with a function that just finds colors of first instances of variations that have the same material and size as the current variation
// List<String> getOtherColors(
//     List<ProductVariation> variations, ProductVariation currentVar) {
//   final currentColor = currentVar.productPropertiesValues
//       .firstWhere(
//         (propertyValue) => propertyValue.property == 'color',
//     orElse: () => ProductPropertyandValue(property: 'color', value: ''),
//   )
//       .value;
//   final currentMaterial = currentVar.productPropertiesValues
//       .firstWhere(
//         (propertyValue) => propertyValue.property == 'material',
//     orElse: () => ProductPropertyandValue(property: 'material', value: ''),
//   )
//       .value;
//   final currentSize = currentVar.productPropertiesValues
//       .firstWhere(
//         (propertyValue) => propertyValue.property == 'size',
//     orElse: () => ProductPropertyandValue(property: 'size', value: ''),
//   )
//       .value;
//
//   // Maintain the order of colors based on their first appearance
//   final originalOrder = <String>[];
//
//   for (var variation in variations) {
//     final isSameMaterial = variation.productPropertiesValues.any(
//           (propertyValue) =>
//       propertyValue.property == 'material' &&
//           propertyValue.value == currentMaterial,
//     );
//     final isSameSize = variation.productPropertiesValues.any(
//           (propertyValue) =>
//       propertyValue.property == 'size' &&
//           propertyValue.value == currentSize,
//     );
//
//     if (isSameMaterial && isSameSize) {
//       final color = variation.productPropertiesValues
//           .firstWhere(
//             (propertyValue) => propertyValue.property == 'color',
//         orElse: () => ProductPropertyandValue(property: 'color', value: ''),
//       )
//           .value;
//       if (!originalOrder.contains(color)) {
//         originalOrder.add(color);
//       }
//     }
//   }
//
//   // Create a set to store unique colors without changing their order
//   final otherColorsSet = LinkedHashSet<String>.from(originalOrder);
//
//   // Include the current color in the set
//   otherColorsSet.add(currentColor);
//
//   // Convert the LinkedHashSet to a List to maintain the order
//   final otherColors = otherColorsSet.toList();
//
//   // Print found colors (Debug Mode)
//   if (kDebugMode) {
//     print('Other colors:');
//     for (String color in otherColors) {
//       print(color);
//     }
//   }
//
//   return otherColors;
// }


List<String> getOtherColors(List<ProductVariation> variations, ProductVariation currentVar) {
  // Initialize an empty list to store other colors
  List<String> otherColors = [];

  // Iterate through the variations to find matches and add colors to the list
  for (ProductVariation variation in variations) {
    // Check if the variation has the same "size" and "material" as the current variation,
    // and the color is not already present in the list
    bool hasMatchingSize = false;
    bool hasMatchingMaterial = false;

    for (ProductPropertyandValue propertyValue in variation.productPropertiesValues) {
      if (propertyValue.property == 'size' && propertyValue.value == currentVar.getSizeValue()) {
        hasMatchingSize = true;
      } else if (propertyValue.property == 'material' && propertyValue.value == currentVar.getMaterialValue()) {
        hasMatchingMaterial = true;
      }
    }

    if (hasMatchingSize && hasMatchingMaterial && !otherColors.contains(variation.getColorValue())) {
      // Add the color to the list
      otherColors.add(variation.getColorValue());
    }
  }

  return otherColors;
}



// List<String> getOtherSizes(
//     List<ProductVariation> variations, ProductVariation currentVar) {
//   final currentColor = currentVar.productPropertiesValues
//       .firstWhere((propertyValue) => propertyValue.property == 'color')
//       .value;
//   final currentMaterial = currentVar.productPropertiesValues
//       .firstWhere((propertyValue) => propertyValue.property == 'material')
//       .value;
//
//   final otherSizes = variations
//       .where((variation) =>
//           variation.productPropertiesValues.any((propertyValue) =>
//               propertyValue.property == 'color' &&
//               propertyValue.value == currentColor) &&
//           variation.productPropertiesValues.any((propertyValue) =>
//               propertyValue.property == 'material' &&
//               propertyValue.value == currentMaterial &&
//               variation.productPropertiesValues
//                       .firstWhere(
//                           (propertyValue) => propertyValue.property == 'size')
//                       .value !=
//                   currentVar.productPropertiesValues
//                       .firstWhere(
//                           (propertyValue) => propertyValue.property == 'size')
//                       .value))
//       .map((variation) => variation.productPropertiesValues
//           .firstWhere((propertyValue) => propertyValue.property == 'size')
//           .value)
//       .toSet()
//       .toList();
//
//   otherSizes.add(currentVar.productPropertiesValues
//           .firstWhere((propertyValue) => propertyValue.property == 'size')
//           .value);
//
//   // Print found sizes (Debug Mode)
//   if (kDebugMode) {
//     print('Other sizes:');
//     for (String size in otherSizes) {
//       print(size);
//     }
//   }
//
//
//   return otherSizes;
// }
//
// List<String> getOtherMaterials(
//     List<ProductVariation> variations, ProductVariation currentVar) {
//   final currentColor = currentVar.productPropertiesValues
//       .firstWhere((propertyValue) => propertyValue.property == 'color')
//       .value;
//   final currentSize = currentVar.productPropertiesValues
//       .firstWhere((propertyValue) => propertyValue.property == 'size')
//       .value;
//
//   final otherMaterials = variations
//       .where((variation) =>
//           variation.productPropertiesValues.any((propertyValue) =>
//               propertyValue.property == 'color' &&
//               propertyValue.value == currentColor) &&
//           variation.productPropertiesValues.any((propertyValue) =>
//               propertyValue.property == 'size' &&
//               propertyValue.value == currentSize &&
//               variation.productPropertiesValues
//                       .firstWhere((propertyValue) =>
//                           propertyValue.property == 'material')
//                       .value !=
//                   currentVar.productPropertiesValues
//                       .firstWhere((propertyValue) =>
//                           propertyValue.property == 'material')
//                       .value))
//       .map((variation) => variation.productPropertiesValues
//           .firstWhere((propertyValue) => propertyValue.property == 'material')
//           .value)
//       .toSet()
//       .toList();
//
//   otherMaterials.add(currentVar.productPropertiesValues
//           .firstWhere((propertyValue) => propertyValue.property == 'material')
//           .value);
//
//   // Print found materials (Debug Mode)
//   if (kDebugMode) {
//     print('Other materials:');
//     for (String material in otherMaterials) {
//       print(material);
//     }
//   }
//
//   return otherMaterials;
// }

List<String> getOtherSizes(List<ProductVariation> variations, ProductVariation currentVar) {
  final currentColor = currentVar.productPropertiesValues
      .firstWhere(
        (propertyValue) => propertyValue.property == 'color',
    orElse: () => ProductPropertyandValue(property: 'color', value: ''),
  )
      .value;
  final currentMaterial = currentVar.productPropertiesValues
      .firstWhere(
        (propertyValue) => propertyValue.property == 'material',
    orElse: () => ProductPropertyandValue(property: 'material', value: ''),
  )
      .value;

  final originalOrder = <String>[];

  for (var variation in variations) {
    final isSameColor = variation.productPropertiesValues.any(
            (propertyValue) =>
        propertyValue.property == 'color' &&
            propertyValue.value == currentColor);
    final isSameMaterial = variation.productPropertiesValues.any(
            (propertyValue) =>
        propertyValue.property == 'material' &&
            propertyValue.value == currentMaterial);

    if (isSameColor && isSameMaterial) {
      final size = variation.productPropertiesValues
          .firstWhere(
            (propertyValue) => propertyValue.property == 'size',
        orElse: () => ProductPropertyandValue(property: 'size', value: ''),
      )
          .value;
      if (!originalOrder.contains(size)) {
        originalOrder.add(size);
      }
    }
  }

  final otherSizesSet = LinkedHashSet<String>.from(originalOrder);
  otherSizesSet.add(currentVar.productPropertiesValues
      .firstWhere(
        (propertyValue) => propertyValue.property == 'size',
    orElse: () => ProductPropertyandValue(property: 'size', value: ''),
  )
      .value);
  final otherSizes = otherSizesSet.toList();

  // Print found sizes (Debug Mode)
  if (kDebugMode) {
    print('Other sizes:');
    for (String size in otherSizes) {
      print(size);
    }
  }

  return otherSizes;
}

List<String> getOtherMaterials(List<ProductVariation> variations, ProductVariation currentVar) {
  final currentColor = currentVar.productPropertiesValues
      .firstWhere(
        (propertyValue) => propertyValue.property == 'color',
    orElse: () => ProductPropertyandValue(property: 'color', value: ''),
  )
      .value;
  final currentSize = currentVar.productPropertiesValues
      .firstWhere(
        (propertyValue) => propertyValue.property == 'size',
    orElse: () => ProductPropertyandValue(property: 'size', value: ''),
  )
      .value;

  final originalOrder = <String>[];

  for (var variation in variations) {
    final isSameColor = variation.productPropertiesValues.any(
            (propertyValue) =>
        propertyValue.property == 'color' &&
            propertyValue.value == currentColor);
    final isSameSize = variation.productPropertiesValues.any(
            (propertyValue) =>
        propertyValue.property == 'size' &&
            propertyValue.value == currentSize);

    if (isSameColor && isSameSize) {
      final material = variation.productPropertiesValues
          .firstWhere(
            (propertyValue) => propertyValue.property == 'material',
        orElse: () => ProductPropertyandValue(property: 'material', value: ''),
      )
          .value;
      if (!originalOrder.contains(material)) {
        originalOrder.add(material);
      }
    }
  }

  final otherMaterialsSet = LinkedHashSet<String>.from(originalOrder);
  otherMaterialsSet.add(currentVar.productPropertiesValues
      .firstWhere(
        (propertyValue) => propertyValue.property == 'material',
    orElse: () => ProductPropertyandValue(property: 'material', value: ''),
  )
      .value);
  final otherMaterials = otherMaterialsSet.toList();

  // Print found materials (Debug Mode)
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

