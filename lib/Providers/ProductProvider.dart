import 'package:flutter/cupertino.dart';

import '../Classes/Product.dart';

class ProductProvider with ChangeNotifier {
  Product? _product;
  Product? get product {
    return _product;
  }

  void setCurrentProduct({required Product? newProduct}) {
    debugPrint("updating current product");
    _product = product;
    notifyListeners();
  }
}
