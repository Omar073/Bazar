import 'package:flutter/cupertino.dart';

import '../Classes/Product.dart';

class ProductsListProvider with ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products {
    return [..._products];
  }

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  void updateList(List<Product> products) {
    _products = products;
    notifyListeners();
  }
}