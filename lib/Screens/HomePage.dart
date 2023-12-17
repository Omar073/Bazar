import 'package:flutter/material.dart';
import '../Classes/Product.dart';
import '../CustomWidgets/ProductCard.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // @override
  // void initState(){
  //   super.initState();
  //   groupProducts();
  // }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        // appBar: AppBar(
        //   leading: Row(
        //     children: [
        //       Text('Welcome Name!'),
        //     ],
        //   ),
        //   actions: [
        //     IconButton(
        //       icon: Icon(Icons.sunny, color: Colors.yellow),
        //       onPressed: () {
        //         // Add your action here
        //       },
        //     ),
        //   ],
        // ),
        body: Column(
        children: [
          Container(
            color: Colors.blue,
            child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 6.0),
                      child: Text('Welcome, Name!',
                          style: TextStyle(fontSize: 20)),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.sunny,
                        color: Colors.yellow,
                      ), // Replace 'your_icon' with the desired icon
                      onPressed: () {
                        // Add your action here
                        // TODO: add dark mode
                      },
                    ),
                  ],
                )),
          ),
          Column( // * Rest of Page Column
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
                          const Text('Top Brands', style: TextStyle(fontSize: 20)),
                          IconButton(onPressed: (){
                            // TODO: add action to view all brands in a new page
                          } , icon: const Icon(Icons.arrow_forward))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row( // * Top Brands Row
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
                              children: defaultVariations.map((variant) => ProductCard(variant: variant)).toList(),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
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
                          const Text('Best sellers', style: TextStyle(fontSize: 20)),
                          IconButton(onPressed: (){
                            // TODO: add action to view all brands in a new page
                          } , icon: const Icon(Icons.arrow_forward))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row( // * Best Sellers Row
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
                              children: defaultVariations.map((variant) => ProductCard(variant: variant)).toList(),
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
    ));
  }
}
