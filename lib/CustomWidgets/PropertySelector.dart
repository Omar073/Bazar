import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:slash_homepage_test/Providers/DarkModeProvider.dart';
import '../Classes/Product.dart';
import '../Classes/ProductProperty.dart';
import '../Classes/ProductPropertyandValue.dart';
import '../Classes/ProductVariation.dart';
import '../Providers/VariantProvider.dart';
import '../UtilityFunctions.dart';
import 'package:provider/provider.dart';

class PropertySelectorWidget extends StatefulWidget {
  final List<ProductPropertyandValue> productPropertiesValues;
  final String property;
  final Product product;
  final ProductVariation currentVariant;

  PropertySelectorWidget({
    Key? key,
    required this.productPropertiesValues,
    required this.property,
    required this.currentVariant,
    required this.product,
  }) : super(key: key);

  @override
  _PropertySelectorWidgetState createState() => _PropertySelectorWidgetState();
}

class _PropertySelectorWidgetState extends State<PropertySelectorWidget> {
  bool isDarkMode = true;
  late double circleDimention;
  @override
  Widget build(BuildContext context) {
    isDarkMode = context.watch<DarkModeProvider>().isDarkMode;
    circleDimention = 30;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   'select the preferred ${widget.property}:',
        //   style: const TextStyle(fontWeight: FontWeight.bold),
        // ),
        const SizedBox(height: 8),
        buildPropertyOption()!,
      ],
    );
  }

  // Color _parseColor(String color) {
  //   try {
  //     return Color(int.parse(color));
  //   } catch (e) {
  //     // Handle the exception, for example, return a default color.
  //     return Colors.grey; // You can choose a default color.
  //   }
  // }

  // Color getColorFromString(String colorName) {
  //   switch (colorName.toLowerCase()) {
  //     case 'red':
  //       return Colors.red;
  //     case 'blue':
  //       return Colors.blue;
  //     case 'green':
  //       return Colors.green;
  //     case 'black':
  //       return Colors.black;
  //     case 'white':
  //       return Colors.white;
  //     case 'grey':
  //       return Colors.grey;
  //     default:
  //       return Colors.orange; // Default color for unknown names
  //   }
  // }

  int snackBarDuration = 1;

  //TODO: lower complexity by making a function for each individual property
  //TODO: or if you can make one very generic function for all of them
  Widget? buildPropertyOption() {
    // ProductPropertyandValue? propertyValue =
    // getPropertyAndValue(widget.property);

    if (widget.property == 'color') {
      if (kDebugMode) {
        print('building color selector');
      }
      List<String> possibleColors =
          getOtherColors(widget.product.variations, widget.currentVariant);
      if (possibleColors.isNotEmpty) {
        return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          for (String color in possibleColors)
            InkWell(
              child: Container(
                width: circleDimention,
                height: circleDimention,
                decoration: BoxDecoration(
                  // color: getColorFromString(color),
                  color: getColorFromHex(color),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color:
                    // widget.currentVariant.getColorValue() == color
                    //     ?
                    // isDarkMode
                            // ? (getColorFromString(color) == Colors.white)
                            //     ? Colors.grey
                            //     : Colors.white
                            // : (getColorFromString(color) == Colors.black)
                            //     ? Colors.grey
                            //     : Colors.black
                    Colors.grey,
                        // : Colors.grey,
                    width: widget.currentVariant.getColorValue() == color
                        ? circleDimention / 10
                        : circleDimention / 25,
                  ),
                ),
              ),
              onTap: () {
                if (widget.currentVariant.getColorValue() != color) {
                  if (kDebugMode) {
                    print('\nfinding product with color: $color');
                    widget.currentVariant.printVariationPropertiesValues();
                  }
                  // context.read<VariantProvider>().setCurrentVariant(
                  var newVariant =
                      widget.product.getVariationByPropertiesValues(
                    productPropertiesValues: [
                      if (widget.currentVariant.productPropertiesValues
                          .any((element) => element.property == 'color'))
                        ProductPropertyandValue(
                          property: 'color',
                          value: color,
                        ),
                      if (widget.currentVariant.productPropertiesValues
                          .any((element) => element.property == 'size'))
                        ProductPropertyandValue(
                          property: 'size',
                          value: widget.currentVariant.getSizeValue(),
                        ),
                      if (widget.currentVariant.productPropertiesValues
                          .any((element) => element.property == 'material'))
                        ProductPropertyandValue(
                          property: 'material',
                          value: widget.currentVariant.getMaterialValue(),
                        ),
                    ],
                  );
                  if (newVariant != null) {
                    debugPrint('new variant is not null from color');
                    context.read<VariantProvider>().setCurrentVariant(
                          newVariant: newVariant,
                        );
                  } else {
                    debugPrint('new variant is null from color');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text(
                          "Sorry, the current property is not available for this color ",
                        ),
                        duration: Duration(seconds: snackBarDuration), // Set the duration in seconds
                      ),
                    );
                    // newVariant = widget.product.getVariationByPropertiesValues(
                    //   productPropertiesValues: [
                    //     ProductPropertyandValue(
                    //       property: 'color',
                    //       value: color,
                    //     ),
                    //     ...widget.currentVariant.productPropertiesValues
                    //         .where((element) => element.property != 'color')
                    //         .map((element) => ProductPropertyandValue(
                    //       property: element.property,
                    //       value: element.value,
                    //     )),
                    //   ],
                    // );
                    newVariant = widget.product.variations.firstWhere(
                          (variant) =>
                          variant.productPropertiesValues.any(
                                (property) =>
                            property.property == 'color' && property.value == color,
                          ),
                      // orElse: () => null,
                    );
                  }
                  context.read<VariantProvider>().setCurrentVariant(newVariant: newVariant);

                  // widget.product.getVariationByPropertiesValues(
                  //   productPropertiesValues: [
                  //     ...widget.currentVariant.productPropertiesValues
                  //         .where((element) => element.property != 'color'),
                  //   ],
                  // ) ??

                  // widget.product.getVariationByPropertiesValues(
                  //                       productPropertiesValues: [
                  //                         ProductPropertyandValue(
                  //                           property: 'color',
                  //                           value: color,
                  //                         ),
                  //                         ...widget.currentVariant.productPropertiesValues
                  //                             .where((element) => element.property != 'color')
                  //                             .map((element) => ProductPropertyandValue(
                  //                           property: element.property,
                  //                           value: element.value,
                  //                         )),
                  //                       ],
                  //                     ),

                  //   ??
                  //   widget.product.getVariationByPropertiesValues(
                  //     productPropertiesValues: [
                  //   ProductPropertyandValue(
                  // property: 'color',
                  // value: color,
                  // ),
                  //       ...widget.currentVariant.productPropertiesValues
                  //           .where((element) => element.property != 'color'),
                  //     ],),

                  //     widget.product.getVariationByPropertiesValues(
                  //   productPropertiesValues: [
                  //     if (widget.currentVariant.productPropertiesValues
                  //         .any((element) => element.property == 'color'))
                  //       ProductPropertyandValue(
                  //         property: 'color',
                  //         value: color,
                  //       ),
                  //     if (widget.currentVariant.productPropertiesValues
                  //         .any((element) => element.property == 'size'))
                  //       ProductPropertyandValue(
                  //         property: 'size',
                  //         value: widget.currentVariant.getSizeValue(),
                  //       ),
                  //     if (widget.currentVariant.productPropertiesValues
                  //         .any((element) =>
                  //             element.property == 'material'))
                  //       ProductPropertyandValue(
                  //         property: 'material',
                  //         value: widget.currentVariant.getMaterialValue(),
                  //       ),
                  //   ],
                  // ),

                  // );
                }
              },
            ),
        ]);
      }
    } else if (widget.property == 'size') {
      if (kDebugMode) {
        print('building size selector');
      }
      List<String> possibleSizes =
          getOtherSizes(widget.product.variations, widget.currentVariant);
      if (possibleSizes.isNotEmpty) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (String size in possibleSizes)
              InkWell(
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue, // Change to the appropriate color
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: widget.currentVariant.getSizeValue() == size
                          ? isDarkMode
                              ? Colors.white
                              : Colors.black
                          : Colors.grey,
                      width: widget.currentVariant.getSizeValue() == size
                          ? 5.0
                          : 2.0,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      size,
                      style: TextStyle(
                        color: widget.currentVariant.getSizeValue() == size
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  if (widget.currentVariant.getSizeValue() != size) {
                    if (kDebugMode) {
                      print('finding product with size: $size');
                      widget.currentVariant.printVariationPropertiesValues();
                    }
                    // context.read<VariantProvider>().setCurrentVariant(
                          var newVariant =
                              widget.product.getVariationByPropertiesValues(
                            productPropertiesValues: [
                              if (widget.currentVariant.productPropertiesValues
                                  .any(
                                      (element) => element.property == 'color'))
                                ProductPropertyandValue(
                                  property: 'color',
                                  value: widget.currentVariant.getColorValue(),
                                ),
                              if (widget.currentVariant.productPropertiesValues
                                  .any((element) => element.property == 'size'))
                                ProductPropertyandValue(
                                  property: 'size',
                                  value: size,
                                ),
                              if (widget.currentVariant.productPropertiesValues
                                  .any((element) =>
                                      element.property == 'material'))
                                ProductPropertyandValue(
                                  property: 'material',
                                  value: widget.currentVariant.getMaterialValue(),
                                ),
                            ],
                          );

                    if (newVariant != null) {
                      debugPrint('new variant is not null from size');
                      context.read<VariantProvider>().setCurrentVariant(
                        newVariant: newVariant,
                      );
                    } else {
                      debugPrint('new variant is null from size');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Sorry, the current property is not available for size: $size ",
                          ),
                          duration: Duration(seconds: snackBarDuration), // Set the duration in seconds
                        ),
                      );
                      // newVariant = widget.product.getVariationByPropertiesValues(
                      //   productPropertiesValues: [
                      //     ProductPropertyandValue(
                      //       property: 'size',
                      //       value: size,
                      //     ),
                      //     ...widget.currentVariant.productPropertiesValues
                      //         .where((element) => element.property != 'size')
                      //         .map((element) => ProductPropertyandValue(
                      //       property: element.property,
                      //       value: element.value,
                      //     )),
                      //   ],
                      // );
                      newVariant = widget.product.variations.firstWhere(
                            (variant) =>
                            variant.productPropertiesValues.any(
                                  (property) =>
                              property.property == 'size' && property.value == size,
                            ),
                        // orElse: () => null,
                      );
                    }
                    context.read<VariantProvider>().setCurrentVariant(newVariant: newVariant);
                        // );
                  }
                },
              ),
          ],
        );
      }
    } else if (widget.property == 'material') {
      if (kDebugMode) {
        print('building material selector');
      }
      List<String> possibleMaterials =
          getOtherMaterials(widget.product.variations, widget.currentVariant);
      if (possibleMaterials.isNotEmpty) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (String material in possibleMaterials)
              InkWell(
                child: Container(
                  width: 80, // Adjust the width as needed
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue, // Change to the appropriate color
                    borderRadius: BorderRadius.circular(25), // Stadium border
                    border: Border.all(
                      color:
                          widget.currentVariant.getMaterialValue() == material
                              ? isDarkMode
                                  ? Colors.white
                                  : Colors.black
                              : Colors.grey,
                      width:
                          widget.currentVariant.getMaterialValue() == material
                              ? 5.0
                              : 2.0,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      material,
                      style: TextStyle(
                        color:
                            widget.currentVariant.getMaterialValue() == material
                                ? Colors.white
                                : Colors.black,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  if (widget.currentVariant.getMaterialValue() != material) {
                    if (kDebugMode) {
                      print('finding product with material: $material');
                      widget.currentVariant.printVariationPropertiesValues();
                    }
                    // context.read<VariantProvider>().setCurrentVariant(
                          var newVariant =
                              widget.product.getVariationByPropertiesValues(
                            productPropertiesValues: [
                              if (widget.currentVariant.productPropertiesValues
                                  .any(
                                      (element) => element.property == 'color'))
                                ProductPropertyandValue(
                                  property: 'color',
                                  value: widget.currentVariant.getColorValue(),
                                ),
                              if (widget.currentVariant.productPropertiesValues
                                  .any((element) => element.property == 'size'))
                                ProductPropertyandValue(
                                  property: 'size',
                                  value: widget.currentVariant.getSizeValue(),
                                ),
                              if (widget.currentVariant.productPropertiesValues
                                  .any((element) =>
                                      element.property == 'material'))
                                ProductPropertyandValue(
                                  property: 'material',
                                  value: material,
                                ),
                            ],
                          );

                    if (newVariant != null) {
                      debugPrint('new variant is not null from material');
                      context.read<VariantProvider>().setCurrentVariant(
                        newVariant: newVariant,
                      );
                    } else {
                      debugPrint('new variant is null from material');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Sorry, the current property is not available for material: $material ",
                          ),
                          duration: Duration(seconds: snackBarDuration), // Set the duration in seconds
                        ),
                      );
                      // newVariant = widget.product.getVariationByPropertiesValues(
                      //   productPropertiesValues: [
                      //     ProductPropertyandValue(
                      //       property: 'material',
                      //       value: material,
                      //     ),
                      //     ...widget.currentVariant.productPropertiesValues
                      //         .where((element) => element.property != 'material')
                      //         .map((element) => ProductPropertyandValue(
                      //       property: element.property,
                      //       value: element.value,
                      //     )),
                      //   ],
                      // );
                      newVariant = widget.product.variations.firstWhere(
                            (variant) =>
                            variant.productPropertiesValues.any(
                                  (property) =>
                              property.property == 'material' && property.value == material,
                            ),
                        // orElse: () => null,
                      );
                    }
                    context.read<VariantProvider>().setCurrentVariant(newVariant: newVariant);
                        // );
                  }
                },
              ),
          ],
        );
      }
    } else {
      return const Text('N/A');
    }
    return null;
  }

  ProductPropertyandValue? getPropertyAndValue(String property) {
    for (ProductPropertyandValue propertyValue
        in widget.productPropertiesValues) {
      if (propertyValue.property == property) {
        return propertyValue;
      }
    }
    return null;
  }
}
