import 'package:flutter/material.dart';
import 'package:movie_list_zul/app/data/config/App_colors.dart';
import 'package:google_fonts/google_fonts.dart';

void showMovieDetails(BuildContext context, Map<String, dynamic> movie) {
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
            decoration: BoxDecoration(color: AppColors.modalBg),
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
