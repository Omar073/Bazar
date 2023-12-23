import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slash_homepage_test/Classes/ProductVariation.dart';
import 'package:slash_homepage_test/Providers/VariantProvider.dart';
import '../Classes/Product.dart';
import '../Providers/DarkModeProvider.dart';
import '../Screens/ProductPage.dart';

class ProductCard extends StatefulWidget {
  ProductVariation variant;
  // ProductCard({super.key, required this.product});
  ProductCard({
    Key? key,
    required this.variant,
  }) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isDarkMode = true;
  @override
  Widget build(BuildContext context) {
    isDarkMode = context.watch<DarkModeProvider>().isDarkMode;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      // color: Colors.grey[300],
      width: 180, // TODO: find best sizing later
      decoration: BoxDecoration(
        border: Border.all(
          color: isDarkMode ? Colors.grey.shade400 : Colors.black,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          InkWell(
              child: Image.asset(
                widget.variant.productVariantImagesURLs![0],
                // width: double.infinity,
                // height: screenHeight/6,
                // width: screenWidth/3,
                width: 180, // TODO: find best sizing later
                height: 150,
                fit: BoxFit.contain,
              ),
              onTap: () {
                // TODO: hero animation for image
                context
                    .read<VariantProvider>()
                    .setCurrentVariant(newVariant: widget.variant);
                // Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPage(product: widget.variant)));
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProductPage()));
              }
          ),
          // const SizedBox(width: 50, child: Text('', style: TextStyle(fontSize: 1),),),
          SizedBox(
            width: 180,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0).copyWith(left: 8.0),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween, // TODO: adjust spacing
                children: [
                  // Text('${widget.variant.getName()!}\nSize: ${widget.variant.getSizeValue()}\n${widget.variant.price} EGP', style: const TextStyle(fontWeight: FontWeight.bold),),
                  Text(
                    '${widget.variant.getName() ?? 'Unknown'}\nSize: ${widget.variant.getSizeValue() ?? 'N/A'}\n${widget.variant.price} EGP',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  // const SizedBox(width: 1.2,),
                  IconButton(
                      onPressed: () {
                        // TODO: add to cart
                      },
                      icon: const Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.orangeAccent,
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
