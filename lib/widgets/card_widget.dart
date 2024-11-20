import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/screens/search_prev_screen.dart';

class MovieCardWidget extends StatelessWidget {
  final Future<List<Show>> future;

  const MovieCardWidget({
    super.key,
    required this.future,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return FutureBuilder<List<Show>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No shows available'));
        }

        List<Show> shows = snapshot.data!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Movies",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: shows.length,
                itemBuilder: (context, index) {
                  final show = shows[index];
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SearchPrevScreen(url: show.links),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: size.height * 0.33,
                              width: size.width * 0.8,
                              child: show.imageUrl.isNotEmpty
                                  ? Image.network(
                                      show.imageUrl,
                                      fit: BoxFit.contain,
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
                                          color: Colors.red,
                                          size: 50,
                                        );
                                      },
                                    )
                                  : const Icon(Icons.tv, size: 50),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              show.name,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            const SizedBox(height: 10),
                            SummaryTextWidget(summary: show.summary),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class SummaryTextWidget extends StatefulWidget {
  final String summary;

  const SummaryTextWidget({
    super.key,
    required this.summary,
  });

  @override
  State<SummaryTextWidget> createState() => _SummaryTextWidgetState();
}

class _SummaryTextWidgetState extends State<SummaryTextWidget> {
  bool isExpanded = false;

  String _removeHtmlTags(String htmlText) {
    final document = parse(htmlText);
    return document.body?.text ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final strippedSummary = _removeHtmlTags(widget.summary);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: AutoSizeText(
            isExpanded
                ? strippedSummary
                : strippedSummary.length > 150
                    ? '${strippedSummary.substring(0, 150)}...'
                    : strippedSummary,
            style: const TextStyle(fontSize: 16, color: Colors.black54),
            textAlign: TextAlign.justify,
            maxLines: isExpanded ? null : 3,
            overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
          ),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Text(
            isExpanded ? "Show Less" : "Show More",
            style: const TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }
}
