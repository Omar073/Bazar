import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
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
                const Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 6.0),
                      child: Text('Welcome, Name!', style: TextStyle(fontSize: 20)),
                    ), // TODO: replace with user's Fname
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.sunny, color: Colors.yellow,), // Replace 'your_icon' with the desired icon
                  onPressed: () {
                    // Add your action here
                    // TODO: add dark mode
                  },
                ),
              ],
            )

          ),
        ),
            Row( // * Top Brands Row
              children: [
                Column(
                  children: [
                    const Text('Top Brands', style: TextStyle(fontSize: 20)),
                  ],
                )
              ],
            )
          ],
        )
      );
  }
}
