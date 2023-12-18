import 'package:flutter/material.dart';
import 'Providers/DarkModeProvider.dart';
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
        ChangeNotifierProvider(
            create: (context) => DarkModeProvider()),
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
  // bool isDarkMode = context.read<DarkModeProvider>().isDarkMode;
      // context.read<VariantProvider>().setCurrentVariant(newVariant: widget.variant);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme : context.watch<DarkModeProvider>().isDarkMode ? ThemeData.dark() : ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: const SafeArea(child: LandingPage()),
    );
  }
}
