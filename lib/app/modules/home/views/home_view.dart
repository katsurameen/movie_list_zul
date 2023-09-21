import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
        // centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
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
            padding: const EdgeInsets.all(16.0),
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
          Obx(
            () => ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: controller.searchQuery.value.isEmpty
                  ? controller.nowPlayingMovies.map((movie) {
                      return ListTile(
                        leading: Container(
                          height: 250,
                          width: 120,
                          child: Image.network(
                            movie['backdrop_path'],
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          movie['title'],
                          style: GoogleFonts.poppins(
                              // textStyle: TextStyle()
                              ),
                        ),
                        subtitle: Text(
                          movie['overview'],
                          textAlign: TextAlign.justify,
                          style: GoogleFonts.poppins(
                              // textStyle: TextStyle()
                              ),
                        ),
                      );
                    }).toList()
                  : controller.filteredMovies.map((movie) {
                      return ListTile(
                        leading: Container(
                          height: 250,
                          width: 120,
                          child: Image.network(
                            movie['backdrop_path'],
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          movie['title'],
                          style: GoogleFonts.poppins(
                              // textStyle: TextStyle()
                              ),
                        ),
                        subtitle: Text(
                          movie['overview'],
                          textAlign: TextAlign.justify,
                          style: GoogleFonts.poppins(
                              // textStyle: TextStyle()
                              ),
                        ),
                      );
                    }).toList(),
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
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.network(
                    movie['poster_path'],
                    width: 160.0,
                    height: 200.0,
                  ),
                  Column(
                    children: [
                      Text(
                        movie['title'],
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        movie['release_date'],
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  )
                ],
              ),
              SizedBox(height: 8.0),
              Text(
                movie['overview'],
                textAlign: TextAlign.justify,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(fontSize: 16.0),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
