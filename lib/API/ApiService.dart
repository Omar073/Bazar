// api_service.dart

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../Classes/Product.dart';
import '../Classes/ProductVariation.dart';

class ApiService {
  final String baseUrl = "https://slash-backend.onrender.com";

  Future<Product> fetchProductDetails(String productId) async {
    final response = await http.get(Uri.parse('$baseUrl/product/$productId'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return Product.fromJson(data); // Implement a fromJson method in Product class
    } else {
      throw Exception('Failed to load product details');
    }
  }
  
  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/product'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> apiBody = json.decode(response.body);
        final List<dynamic> data = apiBody['data'];

        // List to store products
        List<Product> products = [];

        // Iterate through the data and create Product objects
        for (final productData in data) {
          // Extract brand information
          final brandData = productData['Brands'];
          final brandId = brandData['id'];
          final brandName = brandData['brand_name'];
          final brandLogoUrl = brandData['brand_logo_image_path'];

          // Extract product variations
          final List<ProductVariation> variations = [];
          final List<dynamic> variationData = productData['ProductVariations'];
          for (final variation in variationData) {
            // Extract variation images
            final List<String> variationImages = [];
            final List<dynamic> imageList = variation['ProductVarientImages'];
            for (final image in imageList) {
              variationImages.add(image['image_path']);
            }

            variations.add(ProductVariation(
              id: variation['id'],
              productId: variation['product_id'],
              price: variation['price'],
              quantity: variation['quantity'],
              productVariantImagesURLs: variationImages, 
              // Add other properties as needed
            ));
          }

          // Create the Product object
          Product product = Product(
            id: productData['id'],
            name: productData['name'],
            description: productData['description'],
            brandId: productData['brand_id'],
            brandName: brandData['brand_name'],
            brandLogoUrl: brandData['brand_logo_image_path'],
            rating: productData['product_rating'],
            variations: variations,
            // Add other properties as needed
          );

          // Add the product to the list
          products.add(product);
        }
        debugPrint('Product name:  ${products[0].name}');

        return products;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      debugPrint('Error fetching products: $e');
      rethrow; // Rethrow the exception
    }
  }

  // Future<String> fetchProducts() async {
  //   debugPrint('Entered fetchProducts()');
  //
  //   final response = await http.get(Uri.parse('$baseUrl/product'));
  //
  //   if (response.statusCode == 200) {
  //     final Map<String, dynamic> APIbody = json.decode(response.body);
  //     // debugPrint('List of Products: $APIbody');
  //     final List<dynamic> data = APIbody['data'];
  //     debugPrint('List of Products: $data');
  //     // return data.map((productData) => Product.fromJson(productData)).toList();
  //     return '';
  //   } else {
  //     throw Exception('Failed to load products');
  //   }
  // }
}
