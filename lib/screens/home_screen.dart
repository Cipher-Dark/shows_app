import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/screens/search_screen.dart';
import 'package:movie_app/services/api_services.dart';
import 'package:movie_app/widgets/card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Show>> futureShows;

  @override
  void initState() {
    super.initState();
    futureShows = fetchShows().then((data) {
      return data.map((show) => Show.fromJson(show)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: const Text(
            "Home",
            style: TextStyle(
              color: Colors.white,
            ),
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
                      child: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ))),
            )
          ]),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: 2000,
            width: 1000,
            child: MovieCardWidget(future: futureShows),
            // child: ShowListScreen(),
          ),
        ]),
      ),
    );
  }
}
