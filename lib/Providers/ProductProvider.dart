import 'package:flutter/cupertino.dart';

import '../Classes/Product.dart';

class ProductProvider extends ChangeNotifier {
  Product? product;  // TODO: make private?
  Product get productGetter => product!;

  ProductProvider({
    Product? product, 
  }) : this.product = product ?? Product(
    ID: '',
    name: '',
    imageURL: '',
    description: '',
    price: null,
    rating: null,
    productSize: null,
    availableSizes: const [],
    productColor: null,
    availableColors: const [],
  );

  void setCurrentProduct({
    required Product newProduct,
  }) async {
    product = newProduct;
    notifyListeners();
  }
  void setCurrentProductFromColor({
    required String origID,
    required Color wantedColor,
  }) async {
    Product newProduct = products.firstWhere((element) => (element.ID == origID && element.availableColors!.contains(wantedColor)));
    product = newProduct;
    notifyListeners();
  }
  void setCurrentProductFromSize({
    required String origID,
    required AvailableSizes wantedSize,
    required Color wantedColor,
  }) async {
    Product newProduct = products.firstWhere((element) => (element.ID == origID && element.availableSizes!.contains(wantedSize)));
    product = newProduct;
    notifyListeners();
  }
  void setCurrentProductFromCS({
    required String origID,
    required AvailableSizes wantedSize,
    required Color wantedColor,
  }) async {
    print("Original ID: $origID, Wanted Size: ${productSizeToString(wantedSize)}, Wanted Color: ${colorToHex(wantedColor)}");

    Product newProduct = products.firstWhere(
          (element) => (element.ID == origID &&
          element.productSize == wantedSize &&
          element.productColor == wantedColor),
    );

    print("Found Product: $newProduct");
    newProduct.getProductDetails();
    product = newProduct;
    notifyListeners();
    print("Product updated: ${product}");
  }

  static String productSizeToString(AvailableSizes size){
    if (size != null) {
      return size.toString().split('.').last; // Convert enum to string
    } else {
      return 'Unknown Size';
    }
  }

  static String colorToHex(Color color) {
    return '#${color.value.toRadixString(16).substring(2)}';
  }
}