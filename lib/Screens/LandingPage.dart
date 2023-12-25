import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slash_homepage_test/Providers/ProductsListProvider.dart';
import 'package:slash_homepage_test/Screens/HomePage.dart';
import '../API/ApiService.dart';
import '../Classes/Product.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool isLoading = true; // Track loading state
  bool hasNavigated = false;
  ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      // Fetch products from the API
      List<Product> products = await apiService.fetchProducts();

      // Update the state with the fetched products
      context.read<ProductsListProvider>().updateList(products);

      // Set loading state to false
      setState(() {
        isLoading = false;
      });

      // If you need to do something else with the products, you can do it here

    } catch (e) {
      // Handle error if the API call fails
      debugPrint('Error fetching products: $e');
      // Set loading state to false even in case of an error
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // If still loading, show a loading screen
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(), // You can customize the loading indicator
        ),
      );
    }

    // If not loading, show the home page
    return Scaffold(
      body: InkWell(
        onTap: () {
          if (!hasNavigated) {
            hasNavigated = true;
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const SafeArea(child: HomePage()),
              ),
            );
          }
        },
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Text('/.', style: TextStyle(fontSize: 60))),
            Center(
              child: Text(
                'Welcome to Slash\nEmpowering local brands in Egypt',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: Text('Press anywhere to continue'),
            ),
          ],
        ),
      ),
    );
  }
}


// class _LandingPageState extends State<LandingPage> {
//   bool hasNavigated = false;
//   ApiService apiService = ApiService();
//   List<Product> products = [];
//
//   @override
//   void initState() {
//     super.initState();
//     // apiService.fetchProducts().then((fetchedProducts) {
//     //   debugPrint('Products: $fetchedProducts');
//     //   products = fetchedProducts;
//     // });
//     fetchProducts();
//     // context.read<ProductsListProvider>().updateList(products);
//   }
//
//   // Future<void> fetchProducts() async {
//   //   products = await apiService.fetchProducts();
//   //   debugPrint('Products: $products');
//   //   context.read<ProductsListProvider>().updateList(products);
//   // }
//
//   Future<void> fetchProducts() async {
//     try {
//       // Fetch products from the API
//       List<Product> products = await apiService.fetchProducts();
//
//       // Update the state with the fetched products
//       context.read<ProductsListProvider>().updateList(products);
//
//       // If you need to do something else with the products, you can do it here
//
//     } catch (e) {
//       // Handle error if the API call fails
//       debugPrint('Error fetching products: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     products = context.watch<ProductsListProvider>().products;
//     return Scaffold(
//       body: InkWell(
//         onTap: () {
//           if (!hasNavigated) {
//             hasNavigated = true;
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => const SafeArea(child: HomePage())),
//             );
//           }
//         },
//         child: const Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Center(child: Text('/.', style: TextStyle(fontSize: 60))),
//             Center(
//               child: Text(
//                 'Welcome to Slash\nEmpowering local brands in Egypt',
//                 style: TextStyle(fontSize: 20),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(top: 16.0),
//               child: Text('Press anywhere to continue'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
