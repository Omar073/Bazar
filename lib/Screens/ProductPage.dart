import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bazar/CustomWidgets/PropertySelector.dart';
import 'package:bazar/Providers/DarkModeProvider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
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

  //! Problem: the variant properties aren.t detected in the beginning so first tap to a property the snack box appears

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool isDarkMode = true;
  int imageIndex = 0;
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

    Widget buildIndicator() => AnimatedSmoothIndicator(
      effect: const ExpandingDotsEffect(
          dotWidth: 15, activeDotColor: Colors.blue),
      count: Variant?.productVariantImagesURLs!.length as int,
      activeIndex: imageIndex,
    );

    Widget buildImage(String imageUrl, int index) => Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Image.network(imageUrl, fit: BoxFit.contain),
    );

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
              if (Variant?.productVariantImagesURLs != null)
                CarouselSlider.builder(
                  itemCount: Variant?.productVariantImagesURLs!.length,
                  itemBuilder: (context, index, realIndex) {
                    final urlImage = Variant?.productVariantImagesURLs![index];
                    return buildImage(urlImage!, index);
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