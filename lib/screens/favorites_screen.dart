import 'package:flutter/material.dart';
import 'package:cinesphere/favorites_manager.dart'; // Import the FavoritesManager

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoriteMovies = FavoritesManager.instance.favoriteMovies;

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
                final movie = favoriteMovies[index];
                return ListTile(
                  contentPadding: EdgeInsets.all(8),
                  leading: Image.asset(
                    "images/${movie}.jpeg",
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(movie,
                  style: TextStyle(
                     
                  ),
                  ),
                  onTap: () {
                    // Navigate to movie details if needed
                  },
                );
              },
            ),
    );
  }
}