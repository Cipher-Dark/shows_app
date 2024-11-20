import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<dynamic>> fetchShows() async {
  final url = Uri.parse('https://api.tvmaze.com/search/shows?q=all');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data;
  } else {
    throw Exception('Failed to load shows');
  }
}

Future<List<dynamic>> getSearchShow(String searchTerm) async {
  final url = Uri.parse('https://api.tvmaze.com/search/shows?q=$searchTerm');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data;
  } else {
    throw Exception('Failed to load shows');
  }
}

Future<Map<String, dynamic>> searchPage(String searchUrl) async {
  final url = Uri.parse(searchUrl);
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data;
  } else {
    throw Exception('Failed to load shows');
  }
}
