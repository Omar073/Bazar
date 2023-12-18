import 'package:flutter/material.dart';
import 'package:slash_homepage_test/Screens/HomePage.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool hasNavigated = false;

  @override
  void initState() {
    super.initState();
    // * Add any initialization logic here
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
              MaterialPageRoute(builder: (context) => SafeArea(child: HomePage())),
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
              // TODO: try slide to continue in the future
            ),
          ],
        ),
      ),
    );
  }
}
