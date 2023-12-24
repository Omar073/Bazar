import 'package:flutter/cupertino.dart';
import 'package:slash_homepage_test/Classes/ProductVariation.dart';

class DefaultVariationsProvider extends ChangeNotifier {
  List<ProductVariation> _variations = [];

  List<ProductVariation> get variations {
    return [..._variations];
  }

  void addVariation(ProductVariation variation) {
    _variations.add(variation);
    notifyListeners();
  }

  void removeVariation(ProductVariation variation) {
    _variations.remove(variation);
    notifyListeners();
  }

  void clearVariations() {
    _variations.clear();
    notifyListeners();
  }
}
