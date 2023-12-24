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
  bool hasNavigated = false;

  ApiService apiService = ApiService();
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    // apiService.fetchProducts().then((fetchedProducts) {
    //   debugPrint('Products: $fetchedProducts');
    //   products = fetchedProducts;
    // });
    fetchProductss();
    // context.read<ProductsListProvider>().updateList(products);
  }

  Future<void> fetchProductss() async {
    products = await apiService.fetchProducts();
    debugPrint('Products: $products');
    context.read<ProductsListProvider>().updateList(products);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () {
          if (!hasNavigated) {
            hasNavigated = true;
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const SafeArea(child: HomePage())),
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
