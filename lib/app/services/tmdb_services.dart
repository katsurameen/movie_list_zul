import 'package:http/http.dart' as http;
import 'dart:convert';

class TmdbService {
  final String apiKey = '475e612ab0bbe826f16c234ad6f78ea8';
  final String baseUrl = 'https://api.themoviedb.org/3';

  Future<dynamic> getMovies(String category) async {
  final response = await http.get(
    Uri.parse('$baseUrl/movie/$category?api_key=$apiKey'),
  );

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load movies');
  }
}

}
