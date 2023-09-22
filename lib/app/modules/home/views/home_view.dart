import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_list_zul/app/data/config/App_colors.dart';
import '../controllers/home_controller.dart';
import 'movie_details.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dynamic arguments = Get.arguments;
    String name = arguments is String ? arguments : "";
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Movie List',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: AppColors.appBarColor,
        elevation: 10,
        automaticallyImplyLeading: false, // Remove the back arrow
        actions: [
          // Add a logout button/icon to the right of the AppBar
          IconButton(
            icon: Icon(Icons.logout), // You can use any icon you like
            onPressed: () {
              // Get.off(() => FirstScreenView());
              name = "";
              Get.back();
            },
          ),
        ],
      ),
      backgroundColor: AppColors.primaryBg,
      body: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16),
                child: Text(
                  'Hi $name, let\'s explore!',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
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
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 55, 139, 179)
                    .withOpacity(0.5), // Shadow color
                spreadRadius: 2, // Spread radius
                blurRadius: 5, // Blur radius
                offset: Offset(0, 3), // Offset to bottom-right
              ),
            ]),
            height: 200, // Adjust the height as needed
            child: Obx(
              () => ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.movies.length,
                itemBuilder: (context, index) {
                  final movie = controller.movies[index];
                  return GestureDetector(
                    onTap: () => _showMovieDetails(context, movie),
                    child: Material(
                      color: AppColors.modalBg,
                      child: Container(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 133, 133, 133)
                                .withOpacity(0.5), // Shadow color
                            spreadRadius: 2, // Spread radius
                            blurRadius: 4, // Blur radius
                            offset: Offset(1, 2), // Offset to bottom-right
                          ),
                        ], borderRadius: BorderRadius.circular(16.0)),
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
    // Use the imported custom function
    showMovieDetails(context, movie);
  }
}
