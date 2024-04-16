import 'package:flutter/cupertino.dart';
import 'package:bazar/Classes/ProductPropertyandValue.dart';
import 'package:bazar/Classes/ProductVariation.dart';
import '../Classes/Product.dart';

class VariantProvider extends ChangeNotifier {
  ProductVariation? variant; // TODO: make private?
  ProductVariation get variantGetter => variant!;

  // VariantProvider({
  //   ProductVariation? variant,
  // }) : this.variant = variant ??
  //     ProductVariation(
  //       price: null,
  //       productVariantImagesURLs: const[],
  //       productPropertiesValues: const[], id: -1, productId: , quantity: 0, inStock: false,
  //           );

  void setCurrentVariant({required ProductVariation newVariant}) async {
    variant = newVariant;
    debugPrint("\nupdated the current variant to: ${variant?.id}");
    notifyListeners();
  }

  void setCurrentVariantFromProperty(
      {required ProductPropertyandValue productPropertiesValues,
      required Product origP}) async {
    ProductVariation newVariant = origP.variations.firstWhere((element) =>
        (element.productPropertiesValues == productPropertiesValues));
    setCurrentVariant(newVariant: newVariant);
  }

  // void setCurrentVariantFromSize({
  //   required String origID,
  //   required AvailableSizes wantedSize,
  // }) async {
  //   print('select current product from size');
  //   Product newProduct = products.firstWhere((element) =>
  //       (element.ID == origID &&
  //           element.productSize == wantedSize));
  //   print('found product');
  //   product = newProduct;
  //   notifyListeners();
  //   print('product updated');
  //   product?.getProductDetails();
  // }
  //
  // void setCurrentVariantFromCS({
  //   required String origID,
  //   required AvailableSizes wantedSize,
  //   required Color wantedColor,
  // }) async {
  //   print(
  //       "Original ID: $origID, Wanted Size: ${productSizeToString(wantedSize)}, Wanted Color: ${colorToHex(wantedColor)}");
  //
  //   Product newProduct = products.firstWhere(
  //     (element) => (element.ID == origID &&
  //         element.productSize == wantedSize &&
  //         element.productColor == wantedColor),
  //   );
  //
  //   print("Found Product: $newProduct");
  //   newProduct.getProductDetails();
  //   product = newProduct;
  //   notifyListeners();
  //   print("Product updated: ${product}");
  // }

  // static String productSizeToString(AvailableSizes size) {
  //   if (size != null) {
  //     return size.toString().split('.').last; // Convert enum to string
  //   } else {
  //     return 'Unknown Size';
  //   }
  // }
  //
}
