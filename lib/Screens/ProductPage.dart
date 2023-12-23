import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slash_homepage_test/CustomWidgets/PropertySelector.dart';
import 'package:slash_homepage_test/Providers/DarkModeProvider.dart';
import '../Classes/ProductVariation.dart';
import '../Providers/VariantProvider.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductPage extends StatefulWidget {
  // Product product = context.watch<ProductProvider>().productGetter;
  // ProductPage(
  //     {Key? key,
  //       required this.product,})
  //     : super(key: key);
  const ProductPage({
    super.key,
  });

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool isDarkMode = true;
  int imageIndex = 0;

  @override
  Widget build(BuildContext context) {
    ProductVariation? variant = context.watch<VariantProvider>().variantGetter;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    isDarkMode = context.watch<DarkModeProvider>().isDarkMode;

    Widget buildIndicator() => AnimatedSmoothIndicator(
          effect: const ExpandingDotsEffect(
              dotWidth: 15, activeDotColor: Colors.blue),
          count: variant.productVariantImagesURLs!.length,
          activeIndex: imageIndex,
        );

    Widget buildImage(String imageUrl, int index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child: Image.asset(imageUrl, fit: BoxFit.contain),
        );

    if (variant == null || variant.productVariantImagesURLs == null) {
      if (kDebugMode) {
        print("null variant");
      }
      return const Scaffold(
        body: Center(
          child: Text(
            'Loading...',
          ), // You can replace this with a loading indicator or an error message.
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: IconButton(
                icon: Icon(
                  isDarkMode ? Icons.sunny : Icons.nights_stay_rounded,
                  color:
                      isDarkMode ? Colors.orangeAccent : Colors.blue.shade100,
                  size: 29,
                ),
                onPressed: () {
                  context.read<DarkModeProvider>().toggleDarkMode();
                },
              ),
            ),
          ],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${variant.getName()}  ' ?? 'unknown'),
              const Icon(Icons.shopping_bag),
            ],
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (variant.productVariantImagesURLs != null &&
                  variant.productVariantImagesURLs!.isNotEmpty)
                CarouselSlider.builder(
                  itemCount: variant.productVariantImagesURLs!.length,
                  itemBuilder: (context, index, realIndex) {
                    final urlImage = variant.productVariantImagesURLs![index];
                    return buildImage(urlImage, index);
                  },
                  options: CarouselOptions(
                      height: 400,
                      onPageChanged: (index, reason) =>
                          setState(() => imageIndex = index),
                    autoPlay: true,
                    autoPlayAnimationDuration: const Duration(seconds: 2),
                    enlargeCenterPage: true,
                  ),
                ),
              const SizedBox(height: 12),
              buildIndicator(),
              SizedBox(
                height: 20,
                width: screenWidth,
              ),
              Text(
                '${variant.getName() ?? 'unknown'}\n${variant.getDescription() ?? 'no description'}\n${variant.price} EGP',
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              if (variant.productPropertiesValues
                  .any((propertyValue) => propertyValue.property == 'color'))
                Column(
                  children: [
                    const Text(
                      'Available Colors',
                      style: TextStyle(fontSize: 18),
                    ),
                    PropertySelectorWidget(
                      productPropertiesValues: variant.productPropertiesValues,
                      property: 'color',
                      currentVariant: variant,
                      product: variant.getProduct()!,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              if (variant.productPropertiesValues
                  .any((propertyValue) => propertyValue.property == 'size'))
                Column(
                  children: [
                    const Text(
                      'Available Sizes',
                      style: TextStyle(fontSize: 18),
                    ),
                    PropertySelectorWidget(
                      productPropertiesValues: variant.productPropertiesValues,
                      property: 'size',
                      currentVariant: variant,
                      product: variant.getProduct()!,
                    ),
                  ],
                ),
              if (variant.productPropertiesValues
                  .any((propertyValue) => propertyValue.property == 'material'))
                Column(
                  children: [
                    const Text(
                      'Available Materials',
                      style: TextStyle(fontSize: 18),
                    ),
                    PropertySelectorWidget(
                      productPropertiesValues: variant.productPropertiesValues,
                      property: 'material',
                      currentVariant: variant,
                      product: variant.getProduct()!,
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
