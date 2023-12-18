import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slash_homepage_test/CustomWidgets/PropertySelector.dart';
import 'package:slash_homepage_test/Providers/DarkModeProvider.dart';
import '../Classes/Product.dart';
import '../Classes/ProductVariation.dart';
import '../Providers/VariantProvider.dart';

class ProductPage extends StatefulWidget {
  // Product product = context.watch<ProductProvider>().productGetter;
  // ProductPage(
  //     {Key? key,
  //       required this.product,})
  //     : super(key: key);
  ProductPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool isDarkMode = true;
  @override
  Widget build(BuildContext context) {
    ProductVariation? Variant = context.watch<VariantProvider>().variantGetter;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    isDarkMode = context.watch<DarkModeProvider>().isDarkMode;

    if (Variant == null|| Variant.productVariantImagesURLs == null) {
        if (kDebugMode) {
          print("null variant");
        }
      return const Scaffold(
        body: Center(
          child: Text('Loading...'), // You can replace this with a loading indicator or an error message.
        ),
      );
    }
    else {
      return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              isDarkMode ? Icons.nightlight_round_rounded : Icons.sunny,
              color: isDarkMode ? Colors.blue : Colors.yellow,
            ), // Replace 'your_icon' with the desired icon
            onPressed: () {
              context.read<DarkModeProvider>().toggleDarkMode();
            },
          ),        ],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${Variant.getName()}  ' ?? 'unknown'),
            const Icon(Icons.shopping_bag),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // TODO: swipe between multiple images for a single variation
            // Check if productVariantImagesURLs is not null and not empty
            if (Variant.productVariantImagesURLs != null &&
                Variant.productVariantImagesURLs!.isNotEmpty)
            // TODO: swipe between multiple images for a single variation
              Image.asset(
                Variant.productVariantImagesURLs![0],
                width: screenHeight / 2,
                height: screenHeight / 2,
                fit: BoxFit.contain,
              ),
            SizedBox(
              height: 20,
              width: screenWidth,
            ),
            Text(
              '${Variant.getName() ?? 'unkown'}\n${Variant.getDescription() ?? 'no description'}\n${Variant.price} EGP',
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            if (Variant.productPropertiesValues
                .any((propertyValue) => propertyValue.property == 'color'))
              Column(
                children: [
                  const Text(
                    'Available Colors',
                    style: TextStyle(fontSize: 18),
                  ),
                  PropertySelectorWidget(
                      productPropertiesValues: Variant.productPropertiesValues,
                      property: 'color',
                      currentVariant: Variant,
                      product: Variant.getProduct()!),
                  const SizedBox( height: 8,),
                ],
              ),
            if (Variant.productPropertiesValues
                .any((propertyValue) => propertyValue.property == 'size'))
              Column(
                children: [
                  const Text(
                    'Available Sizes',
                    style: TextStyle(fontSize: 18),
                  ),
                  PropertySelectorWidget(
                      productPropertiesValues: Variant.productPropertiesValues,
                      property: 'size',
                      currentVariant: Variant,
                      product: Variant.getProduct()!),
                ],
              ),
            if (Variant.productPropertiesValues
                .any((propertyValue) => propertyValue.property == 'material'))
              Column(
                children: [
                  const Text(
                    'Available Materials',
                    style: TextStyle(fontSize: 18),
                  ),
                  PropertySelectorWidget(
                    productPropertiesValues: Variant.productPropertiesValues,
                    property: 'material',
                    currentVariant: Variant,
                    product: Variant.getProduct()!,
                  ),
                ],
              ),
            const SizedBox( height: 10,),
          ],
        ),
      ),
    );
    }
  }
}
