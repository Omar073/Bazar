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

  const PropertySelectorWidget({
    super.key,
    required this.productPropertiesValues,
    required this.property,
    required this.currentVariant,
    required this.product,
  });

  @override
  _PropertySelectorWidgetState createState() => _PropertySelectorWidgetState();
}

class _PropertySelectorWidgetState extends State<PropertySelectorWidget> {
  bool isDarkMode = true;
  @override
  Widget build(BuildContext context) {
    isDarkMode = context.watch<DarkModeProvider>().isDarkMode;
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
    debugPrint('ENTERED building property option');
    debugPrint('current variant: ${widget.currentVariant.id}');
    debugPrint('current product: ${widget.product.id}');
    debugPrint('current property: ${widget.property}');
    if (widget.currentVariant.productPropertiesValues.isEmpty) {
      debugPrint('\ncurrent variant properties: empty\n');
      //! Problem: it shows that the list is empty although it is not and it loops in it further in the code to fetch properties
    } else {
      debugPrint('\ncurrent variant properties: not empty\n');
    }
    for (ProductPropertyandValue property
        in widget.currentVariant.productPropertiesValues) {
      debugPrint(
          'current variant properties: ${property.property} ${property.value}');
    }

    //! Problem: current property not with border until clicked
    //! Problem: SnackBar showing when not needed

    if (widget.property == 'Color') {
      if (kDebugMode) {
        print('building color selector');
      }
      List<String> possibleColors =
          getOtherColors(widget.product.variations, widget.currentVariant);
      if (possibleColors.isNotEmpty) {
        return SingleChildScrollView(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
            for (String color in possibleColors)
              InkWell(
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: getColorFromHex(color),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: widget.currentVariant
                                  .getColorValue(widget.currentVariant) ==
                              color
                          ? isDarkMode
                              ? (getColorFromHex(color) == Colors.white)
                                  ? Colors.grey
                                  : Colors.white
                              : (getColorFromHex(color) == Colors.black)
                                  ? Colors.grey
                                  : Colors.black
                          : Colors.grey,
                      width: widget.currentVariant
                                  .getColorValue(widget.currentVariant) ==
                              color
                          ? 5.0
                          : 2.0,
                    ),
                  ),
                ),
                onTap: () {
                  if (widget.currentVariant
                          .getColorValue(widget.currentVariant) !=
                      color) {
                    if (kDebugMode) {
                      print('\nfinding product with color: $color');
                      widget.currentVariant.printVariationPropertiesValues();
                    }
                    // context.read<VariantProvider>().setCurrentVariant(
                    var newVariant =
                        widget.product.getVariationByPropertiesValues(
                      productPropertiesValues: [
                        if (widget.currentVariant.productPropertiesValues
                            .any((element) => element.property == 'Color'))
                          ProductPropertyandValue(
                            property: 'Color',
                            value: color,
                          ),
                        if (widget.currentVariant.productPropertiesValues
                            .any((element) => element.property == 'Size'))
                          ProductPropertyandValue(
                            property: 'Size',
                            value: widget.currentVariant
                                .getSizeValue(widget.currentVariant),
                          ),
                        if (widget.currentVariant.productPropertiesValues
                            .any((element) => element.property == 'Materials'))
                          ProductPropertyandValue(
                            property: 'Materials',
                            value: widget.currentVariant
                                .getMaterialValue(widget.currentVariant),
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
                          duration: Duration(
                              seconds:
                                  snackBarDuration), // Set the duration in seconds
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
                        (variant) => variant.productPropertiesValues.any(
                          (property) =>
                              property.property == 'Color' &&
                              property.value == color,
                        ),
                        // orElse: () => null,
                      );
                    }
                    context
                        .read<VariantProvider>()
                        .setCurrentVariant(newVariant: newVariant);

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
                    //         value: widget.currentVariant.getSizeValue(widget.currentVariant),
                    //       ),
                    //     if (widget.currentVariant.productPropertiesValues
                    //         .any((element) =>
                    //             element.property == 'material'))
                    //       ProductPropertyandValue(
                    //         property: 'material',
                    //         value: widget.currentVariant.getMaterialValue(widget.currentVariant),
                    //       ),
                    //   ],
                    // ),

                    // );
                  }
                },
              ),
          ]),
        );
      }
    } else if (widget.property == 'Size') {
      if (kDebugMode) {
        print('building size selector');
      }
      List<String> possibleSizes =
          getOtherSizes(widget.product.variations, widget.currentVariant);
      if (possibleSizes.isNotEmpty) {
        return SingleChildScrollView(
          child: Row(
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
                        color: widget.currentVariant
                                    .getSizeValue(widget.currentVariant) ==
                                size
                            ? isDarkMode
                                ? Colors.white
                                : Colors.black
                            : Colors.grey,
                        width: widget.currentVariant
                                    .getSizeValue(widget.currentVariant) ==
                                size
                            ? 5.0
                            : 2.0,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        size,
                        style: TextStyle(
                          color: widget.currentVariant
                                      .getSizeValue(widget.currentVariant) ==
                                  size
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    if (widget.currentVariant
                            .getSizeValue(widget.currentVariant) !=
                        size) {
                      if (kDebugMode) {
                        print('finding product with size: $size');
                        widget.currentVariant.printVariationPropertiesValues();
                      }
                      // context.read<VariantProvider>().setCurrentVariant(
                      var newVariant =
                          widget.product.getVariationByPropertiesValues(
                        productPropertiesValues: [
                          if (widget.currentVariant.productPropertiesValues
                              .any((element) => element.property == 'Color'))
                            ProductPropertyandValue(
                              property: 'Color',
                              value: widget.currentVariant
                                  .getColorValue(widget.currentVariant),
                            ),
                          if (widget.currentVariant.productPropertiesValues
                              .any((element) => element.property == 'Size'))
                            ProductPropertyandValue(
                              property: 'Size',
                              value: size,
                            ),
                          if (widget.currentVariant.productPropertiesValues.any(
                              (element) => element.property == 'Materials'))
                            ProductPropertyandValue(
                              property: 'material',
                              value: widget.currentVariant
                                  .getMaterialValue(widget.currentVariant),
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
                            duration: Duration(
                                seconds:
                                    snackBarDuration), // Set the duration in seconds
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
                          (variant) => variant.productPropertiesValues.any(
                            (property) =>
                                property.property == 'Size' &&
                                property.value == size,
                          ),
                          // orElse: () => null,
                        );
                      }
                      context
                          .read<VariantProvider>()
                          .setCurrentVariant(newVariant: newVariant);
                      // );
                    }
                  },
                ),
            ],
          ),
        );
      }
    } else if (widget.property == 'Materials') {
      debugPrint('building material selector');
      List<String> possibleMaterials =
          getOtherMaterials(widget.product.variations, widget.currentVariant);
      if (possibleMaterials.isNotEmpty) {
        return SingleChildScrollView(
          child: Row(
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
                        color: widget.currentVariant
                                    .getMaterialValue(widget.currentVariant) ==
                                material
                            ? isDarkMode
                                ? Colors.white
                                : Colors.black
                            : Colors.grey,
                        width: widget.currentVariant
                                    .getMaterialValue(widget.currentVariant) ==
                                material
                            ? 5.0
                            : 2.0,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        material,
                        style: TextStyle(
                          color: widget.currentVariant.getMaterialValue(
                                      widget.currentVariant) ==
                                  material
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    if (widget.currentVariant
                            .getMaterialValue(widget.currentVariant) !=
                        material) {
                      if (kDebugMode) {
                        print('finding product with material: $material');
                        widget.currentVariant.printVariationPropertiesValues();
                      }
                      // context.read<VariantProvider>().setCurrentVariant(
                      var newVariant =
                          widget.product.getVariationByPropertiesValues(
                        productPropertiesValues: [
                          if (widget.currentVariant.productPropertiesValues
                              .any((element) => element.property == 'Color'))
                            ProductPropertyandValue(
                              property: 'Color',
                              value: widget.currentVariant
                                  .getColorValue(widget.currentVariant),
                            ),
                          if (widget.currentVariant.productPropertiesValues
                              .any((element) => element.property == 'Size'))
                            ProductPropertyandValue(
                              property: 'Size',
                              value: widget.currentVariant
                                  .getSizeValue(widget.currentVariant),
                            ),
                          if (widget.currentVariant.productPropertiesValues.any(
                              (element) => element.property == 'Materials'))
                            ProductPropertyandValue(
                              property: 'Materials',
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
                            duration: Duration(
                                seconds:
                                    snackBarDuration), // Set the duration in seconds
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
                          (variant) => variant.productPropertiesValues.any(
                            (property) =>
                                property.property == 'Materials' &&
                                property.value == material,
                          ),
                          // orElse: () => null,
                        );
                      }
                      context
                          .read<VariantProvider>()
                          .setCurrentVariant(newVariant: newVariant);
                      // );
                    }
                  },
                ),
            ],
          ),
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
