import 'package:flutter/cupertino.dart';
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
    return Column(
      children: [
        Text('data', style: TextStyle(fontSize: 30),)
      ],
    );
  }
}
