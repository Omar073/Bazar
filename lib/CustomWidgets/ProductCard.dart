import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Classes/Product.dart';

class ProductCard extends StatefulWidget {
  Product product;
  // ProductCard({super.key, required this.product});
  ProductCard(
      {Key? key,
        required this.product,})
      : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.grey[300],
      child: Column(
        children: [
          // Text('data', style: TextStyle(fontSize: 70),)
          InkWell(
            child: Image.asset(widget.product.imageURL!,
              // width: double.infinity,
              // height: screenHeight/6,
              // width: screenWidth/3,
              width: 180, // TODO: find best sizing later
              height: 130,
              fit: BoxFit.cover,),
            onTap: () {
              // TODO: go to product page
              //print('hi');
            }
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // TODO: adjust spacing
            children: [
              Text(widget.product.name!, style: const TextStyle(fontWeight: FontWeight.bold),),
              const SizedBox(width: 50,),
              IconButton(onPressed: (){
                // TODO: add to cart
              }, icon: const Icon(Icons.shopping_cart_outlined, color: Colors.orangeAccent,))
            ],
          )
        ],
      ),
    );
  }
}
