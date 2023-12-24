import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slash_homepage_test/Classes/ProductVariation.dart';
import 'package:slash_homepage_test/Providers/VariantProvider.dart';
import '../Classes/Product.dart';
import '../Providers/DarkModeProvider.dart';
import '../Screens/ProductPage.dart';

class ProductCard extends StatefulWidget {
  final ProductVariation variant;
  // ProductCard({super.key, required this.product});
  const ProductCard({
    super.key,
    required this.variant,
  });

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
              // child: Image.asset(
              //   widget.variant.productVariantImagesURLs![0],
              //   // width: double.infinity,
              //   // height: screenHeight/6,
              //   // width: screenWidth/3,
              //   width: 180, // TODO: find best sizing later
              //   height: 150,
              //   fit: BoxFit.contain,
              // ),
              child: Image.network(
                widget.variant.productVariantImagesURLs![0],
                // "https://firebasestorage.googleapis.com/v0/b/slash-f711b.appspot.com/o/images%2Fproduct-variants%2F1702842151610image_picker_2D257B4C-6500-4BB9-ADAD-BA7594B78586-7089-000008B2B1A54B9E.jpg?alt=media&token=4cad311e-9cbe-4191-95aa-e61b651bcbdc",
                width: 180,
                height: 150,
                fit: BoxFit.contain,
              ),
            // child:
            // Image.network(
            //     // 'https://m.media-amazon.com/images/I/81muznqvBDL.__AC_SX300_SY300_QL70_ML2_.jpg',
            //   'https://firebasestorage.googleapis.com/v0/b/slash-f711b.appspot.com/o/images%2Fproduct-variants%2F1702840581053image_picker_1AE916AD-0012-4E83-836C-E9FA0EDEB85B-7089-000008A9E2F6374C.jpg?alt=media&token=3c7898f3-3e16-4ddf-bc2d-713fbe29fbd2',
            //   width: 180,
            //   height: 150,
            //   fit: BoxFit.contain,
            // ),
              onTap: () {
                // TODO: hero animation for image
                // context.read<VariantProvider>().setCurrentVariant(newVariant: widget.variant);
                // // Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPage(product: widget.variant)));
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => ProductPage()));
              }),
          // const SizedBox(width: 50, child: Text('', style: TextStyle(fontSize: 1),),),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0).copyWith(left: 12),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, // TODO: adjust spacing
              children: [
                // Text('${widget.variant.getName()!}\nSize: ${widget.variant.getSizeValue()}\n${widget.variant.price} EGP', style: const TextStyle(fontWeight: FontWeight.bold),),
                Text(
                  '${widget.variant.getName() ?? 'UnknownName'}\nSize: ${widget.variant.getSizeValue() ?? 'N/A'}\n${widget.variant.price} EGP',
                  //TODO: add name
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                // const SizedBox(width: 50,),
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
          )
        ],
      ),
    );
  }
}
