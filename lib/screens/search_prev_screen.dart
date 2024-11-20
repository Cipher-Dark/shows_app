import 'package:flutter/material.dart';
import 'package:movie_app/models/search_model.dart';
import 'package:movie_app/services/api_services.dart';

class SearchPrevScreen extends StatefulWidget {
  final String url;

  const SearchPrevScreen({super.key, required this.url});

  @override
  State<SearchPrevScreen> createState() => _SearchPrevScreenState();
}

class _SearchPrevScreenState extends State<SearchPrevScreen> {
  late Future<Show> futureShow;

  @override
  void initState() {
    super.initState();
    futureShow = fetchShowDetails(widget.url);
  }

  Future<Show> fetchShowDetails(String url) async {
    final data = await searchPage(url);
    return Show.fromJson(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Show>(
        future: futureShow,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No details available.'));
          }

          final show = snapshot.data!;
          return Stack(
            children: [
              if (show.imageUrl.isNotEmpty)
                Positioned.fill(
                  child: Image.network(
                    show.imageUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey,
                        child: const Center(
                          child:
                              Icon(Icons.error, size: 100, color: Colors.red),
                        ),
                      );
                    },
                  ),
                )
              else
                Positioned.fill(
                  child: Container(
                    color: Colors.grey,
                    child: const Center(
                      child: Icon(Icons.tv, size: 100, color: Colors.white),
                    ),
                  ),
                ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: AppBar(
                  title: Center(
                    child: Text(
                      show.name,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  backgroundColor: Colors.black.withOpacity(0.6),
                  foregroundColor: Colors.white,
                  elevation: 0,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.8),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        show.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(show.language),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(show.genres[0]),
                              ),
                            ),
                          ),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(" Runtime : ${show.runtime} Min"),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        show.summary,
                        style: const TextStyle(
                          fontSize: 16.5,
                          color: Colors.white70,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
