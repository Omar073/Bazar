import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
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

  //! temporary solution
  Color getColorFromString(String colorName) {
    //TODO: fix this by using colors as hex values
    switch (colorName.toLowerCase()) {
      case 'red':
        return Colors.red;
      case 'blue':
        return Colors.blue;
      case 'green':
        return Colors.green;
      case 'black':
        return Colors.black;
      case 'white':
        return Colors.white;
      default:
        return Colors.orange; // Default color for unknown names
    }
  }

  Widget? buildPropertyOption() {
    // ProductPropertyandValue? propertyValue =
    // getPropertyAndValue(widget.property);

    if (widget.property == 'color') {
      List<String> possibleColors =
          getOtherColors(widget.product.variations, widget.currentVariant);
      if (possibleColors.isNotEmpty) {
        return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          for (String color in possibleColors)
            InkWell(
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: getColorFromString(color),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: widget.currentVariant.getColorValue() == color
                        ? Colors.black
                        : Colors.grey,
                    width: widget.currentVariant.getColorValue() == color
                        ? 5.0
                        : 2.0, // Adjust the thickness of the border
                  ),
                ),
              ),
              onTap: () {
                print(' finding product with color: $color');
                // widget.currentVariant.printVariationDetails();
                // print product property values
                for (ProductPropertyandValue propertyValue in widget.productPropertiesValues) {
                  print('${propertyValue.property}: ${propertyValue.value}');
                }
                context.read<VariantProvider>().setCurrentVariant(
                      newVariant: widget.product.getVariationByPropertiesValues(
                        productPropertiesValues: [
                          ProductPropertyandValue(
                            property: 'color',
                            value: color,
                          ),
                          ProductPropertyandValue(
                            property: 'size',
                            value: widget.currentVariant.getSizeValue()!,
                          ),
                          ProductPropertyandValue(
                            property: 'material',
                            value: widget.currentVariant.getMaterialValue()!,
                          ),
                        ],
                      ),
                    );
              },
            ),
        ]);
      }
    } else if (widget.property == 'size') {
      return const Text('possible sizes');
    } else if (widget.property == 'material') {
      return const Text('possible materials');
    } else {
      return const Text('N/A');
    }

    // return propertyValue != null
    //     ? Text('${property.property}: ${propertyValue.value}')
    //     : Text('${property.property}: N/A');
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
