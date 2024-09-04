import 'package:flutter/material.dart';
import 'package:cinesphere/main.dart'; // Ensure bg_color and text_color are defined here
import 'package:cinesphere/favorites_manager.dart'; // Import the new FavoritesManager

class MovieDescScreen extends StatefulWidget {
  final String movie;

  MovieDescScreen({required this.movie});

  @override
  _MovieDescScreenState createState() => _MovieDescScreenState();
}

class _MovieDescScreenState extends State<MovieDescScreen> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    // Initialize isFavorite by checking if the movie is in the favorite list
    isFavorite = FavoritesManager.instance.isFavorite(widget.movie);
  }

  void _toggleFavorite() {
    setState(() {
      if (isFavorite) {
        FavoritesManager.instance.removeMovie(widget.movie);
      } else {
        FavoritesManager.instance.addMovie(widget.movie);
      }
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg_color,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2.2,
                  child: Image.asset(
                    "images/${widget.movie}.jpeg",
                    fit: BoxFit.cover, // Adjust the fit as needed
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 10,
                  right: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      IconButton(
                        onPressed: _toggleFavorite,
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.movie,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: text_color,
                    ),
                  ),
                  Text(
                    "6h 30min • 2022",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white60,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 51, 57, 52).withOpacity(0.9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "horror",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 134, 124, 124),
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}