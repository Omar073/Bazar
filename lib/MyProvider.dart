import 'package:flutter/cupertino.dart';

import 'Classes/Product.dart';

class MyProvider extends ChangeNotifier {
  Product? product;

  MyProvider({
    Product? product,
  }) : this.product = product ?? Product(
    ID: '',
    name: '',
    imageURL: '',
    description: '',
    price: null,
    rating: null,
    availableSizes: const [],
    availableColors: const [],
  );

  void changeCurrentProduct({
    required Product newproduct,
  }) async {
    product = newproduct;
    notifyListeners();
  }
}