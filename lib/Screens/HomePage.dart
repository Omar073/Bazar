import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slash_homepage_test/Classes/ProductVariation.dart';
import 'package:slash_homepage_test/Providers/DarkModeProvider.dart';
import '../Classes/Product.dart';
import '../CustomWidgets/ProductCard.dart';
import '../Providers/ProductsListProvider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isDarkMode = true;
  List<Product> products = [];
  List<ProductVariation> defaultVariations = [];

  @override
  void initState(){
    super.initState();
    // getDefaultVariations();
  }
  @override
  Widget build(BuildContext context) {
    isDarkMode = context.watch<DarkModeProvider>().isDarkMode;
    double screenWidth = MediaQuery.of(context).size.width;
    products = context.watch<ProductsListProvider>().products;

    void getDefaultVariations() {
      for (var product in products) {
        if (product.variations.isNotEmpty) {
          defaultVariations.add(product.variations[0]);
        }
      }
    }
    getDefaultVariations();

    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
                children: [
          const Text(
            'Slash /.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: isDarkMode ? Colors.grey.shade400 : Colors.black,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(25),
                color: isDarkMode ? Colors.green.shade900 : Colors.blue.shade100,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text('Welcome, Omar!', style: TextStyle(fontSize: 20)),
                  ),
                  IconButton(
                    icon: Icon(
                      isDarkMode ? Icons.nightlight_round_rounded : Icons.sunny,
                      color: isDarkMode ? Colors.blue : Colors.orangeAccent,
                    ), // Replace 'your_icon' with the desired icon
                    onPressed: () {
                      context.read<DarkModeProvider>().toggleDarkMode();
                    },
                  ),
                ],
              ),
            ),
          ),
          Column(
            // * Rest of Page Column
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: screenWidth,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Top Brands',
                              style: TextStyle(fontSize: 20)),
                          IconButton(
                              onPressed: () {
                                // TODO: add action to view all brands in a new page
                              },
                              icon: const Icon(Icons.arrow_forward))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  // * Top Brands Row
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Wrap(

                              spacing: 10, // spacing between items horizontally
                              runSpacing: 10, // spacing between items vertically
                              // children: products.map((p) => ProductCard(product: p)).toList(), // ! thoroughly understand this line
                              // children: defaultVariations.map((variant) => ProductCard(variant: variant)).toList(),
                              children: defaultVariations.map((variant) {
                                // debugPrint('Before ProductCard: ');
                                return ProductCard(variant: variant);
                              }).toList(),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  SizedBox(
                    width: screenWidth,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Best sellers',
                              style: TextStyle(fontSize: 20)),
                          IconButton(
                              onPressed: () {
                                // TODO: add action to view all brands in a new page
                              },
                              icon: const Icon(Icons.arrow_forward))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  // * Best Sellers Row
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Wrap(
                              spacing: 10, // spacing between items horizontally
                              runSpacing: 10, // spacing between items vertically
                              // children: products.map((p) => ProductCard(product: p)).toList(), // ! thoroughly understand this line
                              children: defaultVariations
                                  .map((variant) => ProductCard(variant: variant))
                                  .toList()
                                  .reversed
                                  .toList(),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
                ],
              ),
        ));
  }
}
