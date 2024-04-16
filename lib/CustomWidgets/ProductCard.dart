import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:bazar/Classes/ProductVariation.dart';
import 'package:bazar/Providers/VariantProvider.dart';
import '../API/ApiService.dart';
import '../Classes/Product.dart';
import '../Providers/DarkModeProvider.dart';
import '../Providers/ProductsListProvider.dart';
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
  List<Product> products = [];
  ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    isDarkMode = context.watch<DarkModeProvider>().isDarkMode;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    products = context.watch<ProductsListProvider>().products;

    return Container(
      // color: Colors.grey[300],
      width: 180, // TODO: find best sizing later
      decoration: BoxDecoration(
        // color: Colors.grey[800],
        border: Border.all(
          // color: isDarkMode ? Colors.grey.shade400 : Colors.black,
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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20), // Set the radius as needed
                child: Image.network(
                  widget.variant.productVariantImagesURLs![0],
                  width: 180,
                  height: 150,
                  fit: BoxFit.contain,
                ),
              ),

              // child:
              // Image.network(
              //     // 'https://m.media-amazon.com/images/I/81muznqvBDL.__AC_SX300_SY300_QL70_ML2_.jpg',
              //   'https://firebasestorage.googleapis.com/v0/b/slash-f711b.appspot.com/o/images%2Fproduct-variants%2F1702840581053image_picker_1AE916AD-0012-4E83-836C-E9FA0EDEB85B-7089-000008A9E2F6374C.jpg?alt=media&token=3c7898f3-3e16-4ddf-bc2d-713fbe29fbd2',
              //   width: 180,
              //   height: 150,
              //   fit: BoxFit.contain,
              // ),
              onTap: () async {
                //TODO: add loading screen
                // await apiService.getVariations(products.firstWhere(
                //     (element) => (element.id == widget.variant.productId)));
                Product p = widget.variant.getProduct(products);
                await apiService.getVariations(p);

                //TODO: FIX?

                // context.read<ProductProvider>().setCurrentProduct(
                //     newProduct: products.firstWhere((element) =>
                //     (element.id == widget.variant.productId)));

                // context.read<ProductProvider>.product = products.firstWhere((element) =>
                // (element.id == widget.variant.productId));

                // * here below we update the products list because as you see above when wee called the getVariations method
                // * it updated the variations of the product

                context.read<ProductsListProvider>().updateList(products);

                // Product p = products.firstWhere(
                //     (element) => (element.id == widget.variant.productId));
                debugPrint('\nProduct name: ${p.name}\nProduct ID: ${p.id} \n');

                // TODO: hero animation for image
                // * updating the currently selected variant
                context.read<VariantProvider>().setCurrentVariant(newVariant: widget.variant);
                // Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPage(product: widget.variant)));
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductPage(
                              product: p,
                            )));
              }),

          // const SizedBox(width: 50, child: Text('', style: TextStyle(fontSize: 1),),),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10).copyWith(left: 12),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween, // TODO: adjust spacing
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text('${widget.variant.getName()!}\nSize: ${widget.variant.getSizeValue()}\n${widget.variant.price} EGP', style: const TextStyle(fontWeight: FontWeight.bold),),
                    // Text(
                    //   // '${widget.variant.getName(products) ?? 'UnknownName'}\nSize: ${widget.variant.getSizeValue() ?? 'N/A'}\n${widget.variant.price} EGP',
                    //   '${widget.variant.getName(products) ?? 'UnknownName'}\n${widget.variant.price} EGP',
                    //   style: const TextStyle(fontWeight: FontWeight.bold),
                    // ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: Text(
                        '${widget.variant.getName(products) ?? 'UnknownName'}\n${widget.variant.price} EGP',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
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
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12).copyWith(bottom: 5),
                child: Row(
                  children: [
                    const Text('Rating: ',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    RatingBarIndicator(
                      rating:
                          (widget.variant.getRating(products) ?? 0).toDouble(),
                      itemCount: 5,
                      itemSize: 17.0,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
