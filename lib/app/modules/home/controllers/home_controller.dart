import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_list_zul/app/services/tmdb_services.dart';

class HomeController extends GetxController {
  final TmdbService _tmdbService = TmdbService();
  var movies = [].obs;
  var nowPlayingMovies = [].obs;
  var searchQuery = ''.obs; // Stores the search query
  var filteredMovies = [].obs; // Stores the filtered movies

  @override
  void onInit() {
    super.onInit();
    fetchMovies('now_playing');
    fetchMovies('popular'); // Fetch popular movies by default
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> fetchMovies(String category) async {
    try {
      var data = await _tmdbService.getMovies(category);
      var movieList = data['results'].map((movie) {
        movie['poster_path'] =
            'https://image.tmdb.org/t/p/w500${movie['poster_path']}';
        movie['backdrop_path'] =
            'https://image.tmdb.org/t/p/w500${movie['backdrop_path']}';
        return movie;
      }).toList();

      if (category == 'popular') {
        movies.assignAll(movieList);
        debugPrint('Popular Movies are fetched');
      } else if (category == 'now_playing') {
        // Assign the nowPlayingMovies variable
        nowPlayingMovies.assignAll(movieList);
        debugPrint('Now Playing Movies are fetched');
      }
    } catch (e) {
      debugPrint('Error fetching movies: $e');
    }
  }

  void filterMovies() {
    final query =
        searchQuery.value.toLowerCase(); // Get the lowercase search query
    if (query.isEmpty) {
      // If the query is empty, show all movies
      filteredMovies.assignAll(movies);
    } else {
      // Otherwise, filter movies by title containing the query
      filteredMovies.assignAll(
        movies.where((movie) => movie['title'].toLowerCase().contains(query)),
      );
    }
  }
}
