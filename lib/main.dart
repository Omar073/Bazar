import 'package:flutter/material.dart';
import 'MyProvider.dart';
import 'Screens/LandingPage.dart';
import 'package:provider/provider.dart'; // flutter pub add provider

void main() {
  // runApp(MyApp());
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MyProvider(),
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
