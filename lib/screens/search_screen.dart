import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/screens/search_prev_screen.dart';
import 'package:movie_app/services/api_services.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late Future<List<Show>> futureShows;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureShows = Future.value([]);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void search(String query) {
    setState(() {
      futureShows = getSearchShow(query).then((data) {
        return data.map((show) => Show.fromJson(show)).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Search",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CupertinoSearchTextField(
                padding: const EdgeInsets.all(13),
                controller: searchController,
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                suffixIcon: const Icon(
                  Icons.cancel,
                  color: Colors.grey,
                ),
                style: const TextStyle(color: Colors.grey),
                backgroundColor: Colors.grey.withOpacity(.3),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    search(searchController.text);
                  } else {}
                },
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Show>>(
                future: futureShows,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No shows found.'));
                  }

                  final shows = snapshot.data!;
                  return GridView.builder(
                    padding: const EdgeInsets.all(8.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 5,
                      childAspectRatio: 1.2 / 2,
                    ),
                    itemCount: shows.length,
                    itemBuilder: (context, index) {
                      final show = shows[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SearchPrevScreen(url: show.links),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Expanded(
                              child: show.imageUrl.isNotEmpty
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(
                                        show.imageUrl,
                                        fit: BoxFit.cover,
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        },
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return const Icon(
                                            Icons.error,
                                            size: 50,
                                            color: Colors.red,
                                          );
                                        },
                                      ),
                                    )
                                  : const Icon(
                                      Icons.tv,
                                      size: 50,
                                      color: Colors.grey,
                                    ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              show.name,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
