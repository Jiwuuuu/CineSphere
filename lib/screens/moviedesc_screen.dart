import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cinesphere/screens/movie.dart';
import 'package:cinesphere/favorites_manager.dart';
import 'package:cinesphere/screens/booking.dart';

class MovieDescScreen extends StatefulWidget {
  final Movie movie;

  MovieDescScreen({required this.movie});

  @override
  _MovieDescScreenState createState() => _MovieDescScreenState();
}

class _MovieDescScreenState extends State<MovieDescScreen> {
  late bool isFavorite;
  bool isDescriptionExpanded = false;

  @override
  void initState() {
    super.initState();
    isFavorite = FavoritesManager.instance.isFavorite(widget.movie.title);
  }

  void _toggleFavorite() {
    setState(() {
      if (isFavorite) {
        FavoritesManager.instance.removeMovie(widget.movie.title);
      } else {
        FavoritesManager.instance.addMovie(widget.movie.title);
      }
      isFavorite = !isFavorite;
    });
  }

  void _toggleDescription() {
    setState(() {
      isDescriptionExpanded = !isDescriptionExpanded;
    });
  }

  Future<void> _launchTrailer() async {
    final Uri url = Uri.parse(widget.movie.trailerUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background Image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height / 2.2,
              child: Image.asset(
                widget.movie.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
          // Back and Favorite Buttons
          Positioned(
            top: 50,
            left: 10,
            right: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                IconButton(
                  onPressed: _toggleFavorite,
                  icon: Icon(
                    isFavorite ? Icons.bookmark_add : Icons.bookmark_border,
                    color: Color.fromARGB(255, 235, 216, 16),
                    size: 25,
                  ),
                ),
              ],
            ),
          ),
          // Movie Details
          Positioned(
            top: MediaQuery.of(context).size.height / 2.2,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    widget.movie.title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 147, 235, 136),
                    ),
                  ),
                  SizedBox(height: 10),
                  // Description
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isDescriptionExpanded
                          ? widget.movie.description
                          : (widget.movie.description.length > 100
                              ? widget.movie.description.substring(0, 100) + '...'
                              : widget.movie.description),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8),
                      GestureDetector(
                        onTap: _toggleDescription,
                        child: Text(
                          isDescriptionExpanded ? 'Read Less' : 'Read More',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 235, 216, 16),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  // Genre
                  Row(
                    children: [
                      Text(
                        'Genre: ',
                        style: TextStyle(
                          fontSize: 14,
                          color: const Color.fromARGB(255, 147, 235, 136),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        widget.movie.genre,
                        style: TextStyle(
                          fontSize: 14,
                          color: const Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  // Director
                  Row(
                    children: [
                      Text(
                        'Director: ',
                        style: TextStyle(
                          fontSize: 14,
                          color: const Color.fromARGB(255, 147, 235, 136),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        widget.movie.director,
                        style: TextStyle(
                          fontSize: 14,
                          color: const Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  // Cast
                  Row(
                    children: [
                      Text(
                        'Cast: ',
                        style: TextStyle(
                          fontSize: 14,
                          color: const Color.fromARGB(255, 147, 235, 136),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        widget.movie.cast.join(', '),
                        style: TextStyle(
                          fontSize: 14,
                          color: const Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  // MTRCB Rating
                  Row(
                    children: [
                      Text(
                        'MTRCB Rating: ',
                        style: TextStyle(
                          fontSize: 14,
                          color: const Color.fromARGB(255, 147, 235, 136),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        widget.movie.MTRCBrating as String,
                        style: TextStyle(
                          fontSize: 14,
                          color: const Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  // Buttons Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // See Trailer Button
                      ElevatedButton(
                        onPressed: _launchTrailer,
                        child: Text('See Trailer'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.orange,
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // Book Now Button
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => BookingScreen(movie: widget.movie)),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 51, 57, 52),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "Book Now",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
