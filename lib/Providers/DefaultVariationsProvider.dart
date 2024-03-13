import 'package:flutter/cupertino.dart';
import 'package:bazar/Classes/ProductVariation.dart';

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
