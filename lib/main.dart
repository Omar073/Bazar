import 'package:flutter/material.dart';
import 'Providers/VariantProvider.dart';
import 'Providers/UserProvider.dart';
import 'Screens/LandingPage.dart';
import 'package:provider/provider.dart'; // flutter pub add provider

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
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // TODO: fit into safe area
      debugShowCheckedModeBanner: false,
      home: LandingPage(),
    );
  }
}
