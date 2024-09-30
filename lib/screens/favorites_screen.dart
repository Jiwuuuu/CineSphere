import 'package:flutter/material.dart';
import 'package:cinesphere/favorites_manager.dart'; // Import the FavoritesManager
import 'package:cinesphere/screens/moviedesc_screen.dart'; // Import the MovieDescScreen
import 'package:cinesphere/screens/movie.dart'; // Import the Movie class

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Access favoriteMovies correctly
    final favoriteMovies = FavoritesManager().favoriteMovies; // Ensure you are using Singleton if needed

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white, // Set the back button color to white
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Favorites',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: favoriteMovies.isEmpty
          ? Center(
              child: Text(
                'No favorite movies yet',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: favoriteMovies.length,
              itemBuilder: (context, index) {
                final Movie movie = favoriteMovies[index] as Movie; // Ensure movie is of type Movie
                return ListTile(
                  contentPadding: EdgeInsets.all(8),
                  leading: Image.asset(
                    movie.imageUrl, // Access the imageUrl directly from the Movie object
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    movie.title, // Access the title directly from the Movie object
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    // Navigate to movie details
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDescScreen(movie: movie), // Pass the selected movie
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}