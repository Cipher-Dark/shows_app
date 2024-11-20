class Show {
  final int id;
  final String url;
  final String name;
  final String type;
  final String language;
  final List<String> genres;
  final String? status;
  final int? runtime;
  final String? premiered;
  final String? ended;
  final String? officialSite;
  final String summary;
  final String imageUrl;

  Show({
    required this.id,
    required this.url,
    required this.name,
    required this.type,
    required this.language,
    required this.genres,
    required this.status,
    required this.runtime,
    required this.premiered,
    required this.ended,
    required this.officialSite,
    required this.summary,
    required this.imageUrl,
  });

  factory Show.fromJson(Map<String, dynamic> json) {
    return Show(
      id: json['id'],
      url: json['url'],
      name: json['name'],
      type: json['type'],
      language: json['language'],
      genres: List<String>.from(json['genres']),
      status: json['status'],
      runtime: json['runtime'],
      premiered: json['premiered'],
      ended: json['ended'],
      officialSite: json['officialSite'],
      summary: json['summary'].replaceAll(RegExp(r'<[^>]*>'), ''),
      imageUrl: json['image']['original'],
    );
  }
}
