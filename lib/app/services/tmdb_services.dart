import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TmdbService {
  final String? apiKey = dotenv.env['API_KEY'];
  final String? baseUrl = dotenv.env['BASE_URL'];

  Future<dynamic> getMovies(String category) async {
    if (apiKey == null || baseUrl == null) {
      throw Exception('API_KEY or BASE_URL is missing');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/movie/$category?api_key=$apiKey'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<dynamic> getGenres() async {
    if (apiKey == null || baseUrl == null) {
      throw Exception('API_KEY or BASE_URL is missing');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/genre/movie/list?api_key=$apiKey'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load genres');
    }
  }

  Future<dynamic> getTvs(String category) async {
    if (apiKey == null || baseUrl == null) {
      throw Exception('API_KEY or BASE_URL is missing');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/tv/$category?api_key=$apiKey'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
