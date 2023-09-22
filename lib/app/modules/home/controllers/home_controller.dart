import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_list_zul/app/services/tmdb_services.dart';

class HomeController extends GetxController {
  final TmdbService _tmdbService;
  var movies = [].obs;
  var tvs = [].obs;
  var nowPlayingMovies = [].obs;
  var upcomingMovies = [].obs;
  var genres = [].obs;
  var searchQuery = ''.obs;
  var filteredMovies = [].obs;

  


  HomeController(this._tmdbService);

  @override
  void onInit() {
    super.onInit();
    fetchData('now_playing');
    fetchData('popular');
    fetchData('upcoming');
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> fetchData(String category) async {
    try {
      var movieData = await _tmdbService.getMovies(category);
      var genreData = await _tmdbService.getGenres();

      genres.assignAll(genreData['genres']); // Store the fetched genres

      var movieList = movieData['results'].map((movie) {
        movie['poster_path'] =
            'https://image.tmdb.org/t/p/w500${movie['poster_path']}';
        movie['backdrop_path'] =
            'https://image.tmdb.org/t/p/w500${movie['backdrop_path']}';

        // Extract genre names based on genre IDs
        List<String> genreNames = [];
        for (int genreId in movie['genre_ids']) {
          for (var genre in genres) {
            if (genre['id'] == genreId) {
              genreNames.add(genre['name']);
              break;
            }
          }
        }
        movie['genre_names'] = genreNames;

        return movie;
      }).toList();

      // movie list
      if (category == 'popular') {
        movies.assignAll(movieList);
        debugPrint('Popular Movies are fetched');
      } else if (category == 'now_playing') {
        nowPlayingMovies.assignAll(movieList);
        debugPrint('Now Playing Movies are fetched');
      } else if (category == 'upcoming') {
        upcomingMovies.assignAll(movieList);
        debugPrint('Top Rated Movies are fetched');
      }
    } catch (e) {
      debugPrint('Error fetching data: $e');
    }
  }

  void filterMovies() {
    final query = searchQuery.value.toLowerCase();
    if (query.isEmpty) {
      filteredMovies.assignAll(movies);
    } else {
      filteredMovies.assignAll(
        movies.where((movie) => movie['title'].toLowerCase().contains(query)),
      );
    }
  }
}
