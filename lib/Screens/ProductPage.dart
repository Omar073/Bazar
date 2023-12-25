import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slash_homepage_test/CustomWidgets/PropertySelector.dart';
import 'package:slash_homepage_test/Providers/DarkModeProvider.dart';
import '../Classes/Product.dart';
import '../Classes/ProductVariation.dart';
import '../Providers/ProductProvider.dart';
import '../Providers/ProductsListProvider.dart';
import '../Providers/VariantProvider.dart';

class ProductPage extends StatefulWidget {
  late final Product product;
  // Product product = context.watch<ProductProvider>().productGetter;
  // ProductPage(
  //     {Key? key,
  //       required this.product,})
  //     : super(key: key);
  ProductPage({
    required this.product,
    super.key,
  });

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool isDarkMode = true;
  ProductVariation? Variant;
  late double screenHeight;
  late double screenWidth;
  List<Product> products = [];
  // Product? product;

  @override
  Widget build(BuildContext context) {
    Variant = context.watch<VariantProvider>().variantGetter;
    screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    isDarkMode = context.watch<DarkModeProvider>().isDarkMode;
    products = context.watch<ProductsListProvider>().products;
    // product = context.watch<ProductProvider>().product;
    if (widget.product == null) {
      debugPrint("null product");
      widget.product = Product(
        id: 0,
        brandId: 0,
        brandName: '',
        description: '',
        name: '',
        rating: 0,
      );
    } else {
      debugPrint("not null product");
      widget.product.displayAvailableProperties();
    }

    if (Variant == null || Variant?.productVariantImagesURLs == null) {
      debugPrint("null variant");
      return const Scaffold(
        body: Center(
          child: Text(
              'Loading... or null variant'), // You can replace this with a loading indicator or an error message.
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(
                isDarkMode ? Icons.nightlight_round_rounded : Icons.sunny,
                color: isDarkMode ? Colors.blue : Colors.orangeAccent,
              ), // Replace 'your_icon' with the desired icon
              onPressed: () {
                context.read<DarkModeProvider>().toggleDarkMode();
              },
            ),
          ],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${Variant?.getName(products)}  ' ?? 'unknown'),
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

              // if (Variant?.productVariantImagesURLs != null &&
              //     Variant?.productVariantImagesURLs!.isNotEmpty)
              if (Variant?.productVariantImagesURLs != null)
                // TODO: swipe between multiple images for a single variation
                Image.network(
                  Variant!.productVariantImagesURLs![0],
                  width: screenHeight / 2,
                  height: screenHeight / 2,
                  fit: BoxFit.contain,
                ),
              SizedBox(
                height: 20,
                width: screenWidth,
              ),
              Text(
                '${Variant?.getName(products) ?? 'unkown'}\n${Variant?.getDescription(products) ?? 'no description'}\n${Variant?.price} EGP',
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              if (widget.product.availableProperties
                  .any((propertyValue) => propertyValue.property == 'Color'))
                Column(
                  children: [
                    const Text(
                      'Available Colors',
                      style: TextStyle(fontSize: 18),
                    ),
                    PropertySelectorWidget(
                        productPropertiesValues:
                            Variant!.productPropertiesValues,
                        property: 'Color',
                        currentVariant: Variant!,
                        //TODO"
                        product: widget.product),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              if (widget.product.availableProperties
                  .any((propertyValue) => propertyValue.property == 'Size'))
                Column(
                  children: [
                    const Text(
                      'Available Sizes',
                      style: TextStyle(fontSize: 18),
                    ),
                    PropertySelectorWidget(
                        productPropertiesValues:
                            Variant!.productPropertiesValues,
                        property: 'Size',
                        currentVariant: Variant!,
                        product: widget.product),
                  ],
                ),
              if (widget.product.availableProperties.any(
                  (propertyValue) => propertyValue.property == 'Materials'))
                Column(
                  children: [
                    const Text(
                      'Available Materials',
                      style: TextStyle(fontSize: 18),
                    ),
                    PropertySelectorWidget(
                      productPropertiesValues: Variant!.productPropertiesValues,
                      property: 'Materials',
                      currentVariant: Variant!,
                      product: widget.product,
                    ),
                  ],
                ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      );
    }
  }
}
