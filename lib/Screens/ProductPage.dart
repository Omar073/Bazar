import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slash_homepage_test/CustomWidgets/PropertySelector.dart';
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
  @override
  Widget build(BuildContext context) {
    ProductVariation? Variant = context.watch<VariantProvider>().variantGetter;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

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
        actions: const [
          Icon(Icons.shopping_bag),
        ],
        title: Text(Variant.getName() ?? 'unknown'),
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
            if (Variant.productPropertiesValues
                .any((propertyValue) => propertyValue.property == 'size'))
              const Text(
                'Available Sizes',
                style: TextStyle(fontSize: 18),
              ),
            PropertySelectorWidget(
                productPropertiesValues: Variant.productPropertiesValues,
                property: 'size',
                currentVariant: Variant,
                product: Variant.getProduct()!),
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



            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     if(p.availableColors != null)
            //     for (Color color in p.availableColors!)
            //       InkWell(
            //         child: Container(
            //           width: 60,
            //           height: 60,
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(32.0),
            //             border: Border.all(
            //               color: p.productColor == Colors.black ? Colors.grey : Colors.black,
            //               width: p.productColor == color ? 5.0 : 2.0, // Adjust the thickness of the border
            //             ),
            //           ),
            //           child: Container(
            //             decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(32.0),
            //               color: color,
            //
            //             ),
            //             child: p.productColor == color
            //                 ? const Icon(
            //               Icons.check,
            //               color: Colors.white,
            //             )
            //                 : null,
            //           ),
            //         ),
            //         onTap: () {
            //           if(p.productSize != null && p.productColor != null){
            //             context.read<ProductProvider>().setCurrentProductFromCS(
            //               origID: p.ID!,
            //               wantedSize: p.productSize!,
            //               wantedColor: color,
            //             );
            //           }
            //           else if (p.productColor == null) {
            //             context.read<ProductProvider>().setCurrentProductFromSize(origID: p.ID!, wantedSize: p.productSize!);
            //           }
            //           else if (p.productSize == null) {
            //             context.read<ProductProvider>().setCurrentProductFromColor(origID: p.ID!, wantedColor: color);
            //           }
            //         },
            //       )
            //   ],
            // ),

            //  if(p.availableSizes != null) const Text(
            //    'Available Sizes: ',
            //    style: TextStyle(fontSize: 18),
            //  ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     if(p.availableSizes != null)
            //     for (AvailableSizes size in p.availableSizes!)
            //       InkWell(
            //         child: Container(
            //           width: 60,
            //           height: 60,
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(32.0),
            //             border: Border.all(
            //               color: Colors.black,
            //               width: p.productSize == size ? 5.0 : 2.0,
            //             ),
            //           ),
            //           child: Center(
            //             child: Text(
            //               size.toString().split('.').last,
            //               style: const TextStyle(fontSize: 18),
            //             ),
            //           ),
            //         ),
            //         onTap: () {
            //           if(p.productSize != null && p.productColor != null){
            //             context.read<ProductProvider>().setCurrentProductFromCS(
            //               origID: p.ID!,
            //               wantedSize: size,
            //               wantedColor: p.productColor!,
            //             );
            //           }
            //           else if (p.productColor == null) {
            //             context.read<ProductProvider>().setCurrentProductFromSize(origID: p.ID!, wantedSize: size);
            //           }
            //           else if (p.productSize == null) {
            //             context.read<ProductProvider>().setCurrentProductFromColor(origID: p.ID!, wantedColor: p.productColor!);
            //           }
            //         },
            //       ),
            //   ],
            // ),
          ],
        ),
      ),
    );
    }
  }
}
