import 'package:cinesphere/database/supabase_service.dart';
import 'package:cinesphere/main.dart';
import 'package:flutter/material.dart';
import 'package:cinesphere/screens/movie.dart';
import 'package:cinesphere/screens/moviedesc_screen.dart';
import 'package:cinesphere/screens/favorites_screen.dart';
import 'package:google_fonts/google_fonts.dart';

final supabaseClient = SupabaseService().client;

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg_color,
      appBar: AppBar(
        backgroundColor: bg_color,
        elevation: 0,
        title: Row(
          children: [
            Text(
              "CS",
              style: GoogleFonts.lexend(
                fontWeight: FontWeight.bold,
                color: header_text,
                fontSize: 20,
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: TextField(
                style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 255, 255, 255),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Search',
                  hintStyle: TextStyle(color: bg_color),
                  prefixIcon: Icon(Icons.search, color: bg_color),
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Movie>>(
        future: fetchMovies(), // Fetch movies from Supabase
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No movies found.'));
          }

          // Assuming the data is fetched successfully
          final List<Movie> movies = snapshot.data!;

          // Split movies into three categories based on status
          final List<Movie> nowPlayingMovies = movies.where((movie) => movie.status == 'Now Showing').toList();
          final List<Movie> upcomingMovies = movies.where((movie) => movie.status == 'Coming Soon').toList();
          final List<Movie> advanceSellingMovies = movies.where((movie) => movie.status == 'Advance Selling').toList();

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCategorySection("Now Showing", nowPlayingMovies, context),
                _buildCategorySection("Advance Selling", advanceSellingMovies, context),
                _buildCategorySection("Coming Soon", upcomingMovies, context),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: Color(0xFF07130E),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0x3D40E49F),
              blurRadius: 4,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildBottomBarItem(Icons.favorite_outline, 'Favorites', () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritesScreen(),
                ),
              );
            }),
            _buildBottomBarItem(Icons.home_outlined, 'Home', () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              );
            }),
            _buildBottomBarItem(Icons.notifications_outlined, 'Transaction', () {
              // Implement notifications functionality if needed
            }),
          ],
        ),
      ),
    );
  }

  // Fetch movies from Supabase
  Future<List<Movie>> fetchMovies() async {
    try {
      final response = await supabaseClient
          .from('movies') // Your Supabase table name
          .select(); // Cast the result as a List of Map

      // Map the response data to List<Movie>
      final List<Movie> movies = response.map((item) {
        return Movie(
          title: item['title'],
          genre: item['genre'],
          director: item['director'],
          cast: List<String>.from(item['cast']),
          mtrcb_rating: item['mtrcb_rating'],
          description: item['description'],
          poster_url: item['poster_url'],
          trailer_link: item['trailer_link'],
          status: item['status'], // Include status here
        );
      }).toList();

      return movies;
    } catch (error) {
      throw Exception('Failed to load movies: $error');
    }
  }

  Widget _buildBottomBarItem(IconData icon, String label, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: icon_color),
          SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              color: text,
              fontSize: 12,
              fontFamily: 'Lexend Deca',
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

Widget _buildCategorySection(String title, List<Movie> movies, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(left: 15, top: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min, // Use min to constrain the column's height
      children: [
        Text(
          title,
          style: GoogleFonts.lexend(fontSize: 24, fontWeight: FontWeight.w800, color: header_text),
        ),
        SizedBox(height: 10),
        SizedBox(
          height: 250, // Adjust height as needed
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // Navigate to movie description screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDescScreen(movie: movies[index]),
                    ),
                  );
                },
                child: Container(
                  width: 150, // Adjust width as needed
                  margin: EdgeInsets.only(right: 10),
                  child: Column(
                    children: [
                      // Poster Image
                      Container(
                        height: 200, // Adjust height as needed
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(movies[index].poster_url.isEmpty 
                              ? 'images/default_image_url.jpg' // Use a default image if poster_url is empty
                              : movies[index].poster_url),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      SizedBox(height: 4), // Spacing between poster and text
                      // Title and Genre below the poster
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Title with truncation
                          Text(
                            truncateTitle(movies[index].title, maxLength: 15), // Use the helper function
                            style: GoogleFonts.lexend(
                              color: text,
                              fontWeight: FontWeight.bold,
                              fontSize: 18, // Adjust font size as needed
                            ),
                            maxLines: 1, // Limit to 1 line
                            overflow: TextOverflow.ellipsis, // Show ellipsis for overflow
                          ),
                          SizedBox(height: 2),
                          // Genre
                          Text(
                            movies[index].genre,
                            style: GoogleFonts.lexend(
                              color: text,
                              fontSize: 12, // Adjust font size as needed
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}


String truncateTitle(String title, {int maxLength = 15}) {
  if (title.length > maxLength) {
    return '${title.substring(0, maxLength)}...'; // Truncate and add ellipsis
  }
  return title; // Return original title if within length
}

}
