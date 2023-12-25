// api_service.dart

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../Classes/Product.dart';
import '../Classes/ProductPropertyandValue.dart';
import '../Classes/ProductVariation.dart';
import '../UtilityFunctions.dart';

class ApiService {
  final String baseUrl = "https://slash-backend.onrender.com";

  Future<Product> fetchProductDetails(String productId) async {
    final response = await http.get(Uri.parse('$baseUrl/product/$productId'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return Product.fromJson(
          data); // Implement a fromJson method in Product class
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
        // debugPrint('Product name:  ${products[0].name}');

        return products;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      debugPrint('Error fetching products: $e');
      rethrow; // Rethrow the exception
    }
  }

  // * gets all variations of all products in the list
  Future<List<Product>> getProductsVariations(List<Product> products) async {
    try {
      for (final product in products) {
        await getVariations(product);
      }
      return products;
    } catch (e) {
      debugPrint('Error fetching products: $e');
      rethrow; // Rethrow the exception
    }
  }

  // * gets all variations of a single product
  Future<Product> getVariations(Product product) async {
    // takes the product and adds the variations to it
    debugPrint('Entered getVariations() ${product.id}');
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/product/${product.id}'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> apiBody = json.decode(response.body);
        final Map<String, dynamic> productData = apiBody['data'];

        // Extract variations data
        final List<dynamic> variationData = productData['variations'];

        // List to store variations
        List<ProductVariation> variations = [];

        // Iterate through the variation data and create ProductVariation objects
        for (final variation in variationData) {
          // loop through each variation
          // Extract variation images
          final List<String> variationImages = [];
          final List<dynamic> imageList = variation['ProductVarientImages'];
          for (final image in imageList) {
            variationImages.add(image['image_path']);
          }

          // Extract product properties and values
          final List<ProductPropertyandValue> productPropertiesValues = [];
          final List<dynamic> propertiesValuesList =
              variation['productPropertiesValues'];
          for (final propertyData in propertiesValuesList) {
            final property = propertyData['property'];
            final value = propertyData['value'];
            // for (final valueData in values) {
            productPropertiesValues.add(ProductPropertyandValue(
              property: property,
              value: value,
              //debugPrint PROPERTY AND VALUE
            ));
            debugPrint('\nVARIATION ID: ${variation['id']}');
            debugPrint('PROPERTY: $property');
            debugPrint('VALUE: $value\n');
            // }
          }
          //display properties and values debugPrint for each variation
          // * WORKS
          // debugPrint(
          //     '\nProduct Properties and Values for variation with ID: ${variation['id']}');
          // printPropertyandValue(productPropertiesValues);

          // Create the ProductVariation object
          ProductVariation variationObject = ProductVariation(
            id: variation['id'],
            productId: variation['product_id'] as int? ?? 0,
            price: variation['price'] as int?, // Use 'as int?' to allow null
            quantity: variation['quantity'],
            inStock: variation['inStock'],
            productVariantImagesURLs: variationImages,
            productPropertiesValues: productPropertiesValues,
            // Add other properties as needed
          );
          // debugPrint(
          //     '\n\nVARIATION ID: ${variation['id']}\nVariation Color: ${variationObject.getColorValue(variationObject)}\n'
          //     'Variation Size: ${variationObject.getSizeValue()}\nVariation Material: ${variationObject.getMaterialValue()}\n\n');

          // Add the variation to the list
          if (!variations.contains(variationObject)) {
            variations.add(variationObject);
          }
        }

        // Update the product with the new variations
        product.variations = variations;
        product.availableProperties = getProductProperties(variations);
      } else {
        throw Exception('Failed to load variations for product ${product.id}');
      }
    } catch (e) {
      debugPrint('Error fetching variations: $e');
      rethrow; // Rethrow the exception
    }
    debugPrint('Variations for product ${product.id} fetched successfully');
    return product;
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
