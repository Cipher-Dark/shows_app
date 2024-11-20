import 'dart:convert';
import 'dart:ffi';

class Show {
  final String name;
  final double rating;
  final String imageUrl;

  int id;
  String language;
  // String genres;
  String status;
  int? runtime;
  int? averageRuntime;
  String premiered;
  String ended;
  String officialSite;

  String summary;
  String links;

  Show({
    required this.name,
    required this.rating,
    required this.imageUrl,
    required this.id,
    required this.summary,
    required this.links,
    required this.officialSite,
    required this.ended,
    required this.premiered,
    required this.averageRuntime,
    required this.runtime,
    required this.status,
    // required this.genres,
    required this.language,
  });

  // Factory constructor to create a Show object from JSON
  factory Show.fromJson(Map<String, dynamic> json) {
    return Show(
      name: json['show']['name'] ?? 'Unknown',
      rating: json['show']['rating'] != null &&
              json['show']['rating']['average'] != null
          ? json['show']['rating']['average'].toDouble()
          : 0.0,
      imageUrl: json['show']['image'] != null
          ? json['show']['image']['original']
          : '',
      summary: json['show']['summary'] ?? 'Unknown',
      links: json['show']['_links']['self']['href'] ?? 'Unknown',
      officialSite: json['show']['officialSite'] ?? 'Unknown',
      ended: json['show']['ended'] ?? 'Unknown',
      premiered: json['show']['premiered'] ?? 'Unknown',
      averageRuntime: json['show']['averageRuntime'],
      runtime: json['show']['runtime'],
      status: json['show']['status'] ?? 'Unknown',
      // genres: json['show']['genres'],
      language: json['show']['language'] ?? 'Unknown',
      id: json['show']['id'],
    );
  }
}
