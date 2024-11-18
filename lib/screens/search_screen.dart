import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: Image.asset(
          "assets/brand.png",
          height: 50,
          width: 120,
        ),
      ),
      body: const SafeArea(child: Row(children: [])),
    );
  }
}
