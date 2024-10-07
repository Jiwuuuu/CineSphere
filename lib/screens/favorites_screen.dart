import 'package:flutter/material.dart';
import 'package:cinesphere/favorites_manager.dart';
import 'package:cinesphere/screens/moviedesc_screen.dart';
import 'package:cinesphere/screens/movie.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoriteMovies = FavoritesManager().favoriteMovies;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
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
                final Movie movie = favoriteMovies[index];
                return ListTile(
                  contentPadding: EdgeInsets.all(8),
                  leading: Image.asset(
                    movie.poster_url,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    movie.title,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDescScreen(movie: movie),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}