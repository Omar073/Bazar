import 'package:flutter/material.dart';
import 'Classes/Product.dart';
import 'Classes/ProductVariation.dart';
import 'Providers/DarkModeProvider.dart';
import 'Providers/ProductProvider.dart';
import 'Providers/ProductsListProvider.dart';
import 'Providers/VariantProvider.dart';
import 'Providers/UserProvider.dart';
import 'Screens/LandingPage.dart';
import 'package:provider/provider.dart'; // flutter pub add provider

// in provider : watch = ben fetch el data bene2ra mn ba3eed (listen to changes)
// read means ba access el data mn el provider (don't listen to changes)

void main() {
  // runApp(MyApp());
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => VariantProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(create: (context) => DarkModeProvider()),
        ChangeNotifierProvider(create: (context) => ProductsListProvider(),),
        ChangeNotifierProvider(create: (context) => ProductProvider(),),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // List<Product> products = [];
  // List<ProductVariation> defaultVariations = [];
  // bool isDarkMode = context.read<DarkModeProvider>().isDarkMode;
  bool isDarkMode = true;
  // context.read<VariantProvider>().setCurrentVariant(newVariant: widget.variant);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: context.watch<DarkModeProvider>().isDarkMode
          ? ThemeData.dark()
          : ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: const SafeArea(child: LandingPage()),
    );

  }
}
