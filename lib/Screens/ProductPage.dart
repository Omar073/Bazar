import 'dart:js';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Classes/Product.dart';
import '../Providers/ProductProvider.dart';

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
    Product p = context.watch<ProductProvider>().productGetter;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        actions: [const Icon(Icons.shopping_bag),],
        title: Text(p.name!),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            p.imageURL!,
            width: screenHeight / 2,
            height: screenHeight / 2,
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: 20,
            width: screenWidth,
          ),
          Text(
            '${p.name!}\n${p.description!}\n${p.price} EGP',
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          if(p.availableColors != null) const Text('Available Colors',
            style: TextStyle(fontSize: 18),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if(p.availableColors != null)
              for (Color color in p.availableColors!)
                InkWell(
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32.0),
                      border: Border.all(
                        color: p.productColor == Colors.black ? Colors.grey : Colors.black,
                        width: p.productColor == color ? 5.0 : 2.0, // Adjust the thickness of the border
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32.0),
                        color: color,

                      ),
                      child: p.productColor == color
                          ? const Icon(
                        Icons.check,
                        color: Colors.white,
                      )
                          : null,
                    ),
                  ),
                  onTap: () {
                    if(p.productSize != null && p.productColor != null){
                      context.read<ProductProvider>().setCurrentProductFromCS(
                        origID: p.ID!,
                        wantedSize: p.productSize!,
                        wantedColor: color,
                      );
                    }
                    else if (p.productColor == null) {
                      context.read<ProductProvider>().setCurrentProductFromSize(origID: p.ID!, wantedSize: p.productSize!);
                    }
                    else if (p.productSize == null) {
                      context.read<ProductProvider>().setCurrentProductFromColor(origID: p.ID!, wantedColor: color);
                    }
                  },
                )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
           if(p.availableSizes != null) const Text(
             'Available Sizes: ',
             style: TextStyle(fontSize: 18),
           ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if(p.availableSizes != null)
              for (AvailableSizes size in p.availableSizes!)
                InkWell(
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32.0),
                      border: Border.all(
                        color: Colors.black,
                        width: p.productSize == size ? 5.0 : 2.0,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        size.toString().split('.').last,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  onTap: () {
                    if(p.productSize != null && p.productColor != null){
                      context.read<ProductProvider>().setCurrentProductFromCS(
                        origID: p.ID!,
                        wantedSize: size,
                        wantedColor: p.productColor!,
                      );
                    }
                    else if (p.productColor == null) {
                      context.read<ProductProvider>().setCurrentProductFromSize(origID: p.ID!, wantedSize: size);
                    }
                    else if (p.productSize == null) {
                      context.read<ProductProvider>().setCurrentProductFromColor(origID: p.ID!, wantedColor: p.productColor!);
                    }
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }
}
