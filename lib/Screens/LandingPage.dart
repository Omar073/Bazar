import 'package:flutter/material.dart';
import 'package:slash_homepage_test/Screens/HomePage.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // TODO: add dark mode
        body: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
          },
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Text('/.', style: TextStyle(fontSize: 60))),
              Center(child: Text('Welcome to Slash\nEmpowering local brands in Egypt', style: TextStyle(fontSize: 20), textAlign: TextAlign.center,)),
              Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Text('Press anywhere to continue'),
                // TODO: try slide to continue in the future
              ),

            ],
          ),
        )
      );
  }
}
