import 'package:flutter/material.dart';
import 'package:movie_app/screens/search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
          actions: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: ClipPath(
                  child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SearchScreen()));
                      },
                      child: const Icon(Icons.search))),
            )
          ]),
      body: const SafeArea(child: Row(children: [])),
    );
  }
}
