enum AvailableSizes { S, M, L, XL, XXL, XXXL }

enum ProductColor { Blue, Red, Green, Yellow, White, Black }

class Product {
  String ID;
  String name;
  String imageURL;
  String description;
  double price;
  double rating;
  List<AvailableSizes> availableSizes;
  List<ProductColor> availableColors;

  // Constructor
  Product({
    required this.ID,
    required this.name,
    required this.imageURL,
    required this.description,
    required this.price,
    required this.rating,
    required this.availableSizes, // changed from AvailableSizes to availableSizes
    required this.availableColors,
  });
}

List<Product> products = [
  Product(
    ID: 'T1', name: 'T-Shirt', imageURL: 'example.com/tshirt.jpg',
    description: 'Comfortable cotton t-shirt', price: 19.99, rating: 4.2,
    availableSizes: [AvailableSizes.S, AvailableSizes.M, AvailableSizes.L],
    availableColors: [ProductColor.Blue, ProductColor.Red],
  ),
  Product(
    ID: 'T2', name: 'Sweater', imageURL: 'example.com/sweater.jpg',
    description: 'Warm wool sweater for winter', price: 49.99, rating: 4.5,
    availableSizes: [AvailableSizes.M, AvailableSizes.L, AvailableSizes.XL],
    availableColors: [ProductColor.Green, ProductColor.Black],
  ),
  Product(
    ID: 'B1', name: 'Jeans', imageURL: 'example.com/jeans.jpg',
    description: 'Classic denim jeans', price: 39.99, rating: 4.0,
    availableSizes: [AvailableSizes.S, AvailableSizes.M],
    availableColors: [ProductColor.Blue, ProductColor.Black],
  ),
  Product(
    ID: 'S1', name: 'Shoes', imageURL: 'example.com/Shoes.jpg',
    description: 'Amazing Shoes', price: 49.99, rating: 5.0,
    availableSizes: [AvailableSizes.S, AvailableSizes.M, AvailableSizes.L],
    availableColors: [ProductColor.Blue, ProductColor.Black, ProductColor.Red],
  ),
  Product(
    ID: 'A1', name: 'Watch', imageURL: 'example.com/Watch.jpg',
    description: 'Tells the time', price: 49.99, rating: 5.0,
    availableSizes: [],
    availableColors: [ProductColor.Blue, ProductColor.Black, ProductColor.White],
  ),
  // Add more products as needed
];