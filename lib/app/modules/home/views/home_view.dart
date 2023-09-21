import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_list_zul/app/data/config/App_colors.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Movie List',
          style: GoogleFonts.poppins(
              textStyle:
                  TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
        ),
        backgroundColor: AppColors.appBarColor,
        elevation: 10, // Adjust the elevation to control the shadow intensity
      ),
      backgroundColor: AppColors.primaryBg,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16),
            child: Text(
              'Welcome, lets explore!',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0.0),
            child: Text(
              'Popular',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            height: 200, // Adjust the height as needed
            child: Obx(
              () => ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.movies.length,
                itemBuilder: (context, index) {
                  final movie = controller.movies[index];
                  return GestureDetector(
                    onTap: () => _showMovieDetails(context, movie),
                    child: Container(
                      margin: EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Column(
                          children: [
                            Image.network(
                              movie['poster_path'],
                              width: 120.0,
                              height: 180.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 16.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Now playing!',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 35.0, // Adjust the height as needed
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search Movie',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.grey[200],
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 10.0),
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            controller.searchQuery.value = '';
                            controller.filterMovies();
                          },
                        ),
                      ),
                      onChanged: (value) {
                        controller.searchQuery.value = value;
                        controller.filterMovies();
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
          SingleChildScrollView(
            child: Obx(
              () => ListView.builder(
                shrinkWrap: true,
                physics:
                    NeverScrollableScrollPhysics(), // Disable scrolling for the ListView.builder
                itemCount: controller.searchQuery.value.isEmpty
                    ? controller.nowPlayingMovies.length
                    : controller.filteredMovies.length,
                itemBuilder: (context, index) {
                  final movie = controller.searchQuery.value.isEmpty
                      ? controller.nowPlayingMovies[index]
                      : controller.filteredMovies[index];

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: Container(
                            width: 120,
                            child: Image.network(
                              movie['poster_path'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16.0,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movie['title'],
                                style: GoogleFonts.poppins(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    movie['overview'],
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.justify,
                                    style: GoogleFonts.poppins(),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        _showMovieDetails(context, movie),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Continue reading',
                                          style: GoogleFonts.poppins(),
                                        ),
                                        Icon(Icons.arrow_forward),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  void _showMovieDetails(BuildContext context, Map<String, dynamic> movie) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        // Calculate star rating
        dynamic voteAverage = movie['vote_average'];
        String formattedVoteAverage = '';

        if (voteAverage is int) {
          formattedVoteAverage = '$voteAverage';
        } else if (voteAverage is double) {
          formattedVoteAverage = voteAverage.toStringAsFixed(1);
        }

        List<String> genreNames = movie['genre_names'] ?? <String>[];

        return ListView(
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.network(
                      movie['backdrop_path'],
                      width: 378.0,
                      height: 180.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          movie['title'],
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Release date:",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        movie['release_date'],
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Spacer(), // Add this spacer to push the star rating to the right
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          Text(
                            formattedVoteAverage, // Display the calculated star rating
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Genres:",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: Text(
                          genreNames.join(
                              ', '), // Display genre names separated by commas
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    "Overview",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.clip,
                  ),
                  Text(
                    movie['overview'],
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(fontSize: 16.0),
                    ),
                    overflow: TextOverflow.clip,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
