import 'package:cinesphere/screens/favorites_screen.dart';
import 'package:flutter/material.dart';
import 'package:cinesphere/screens/movie.dart';
import 'package:cinesphere/screens/moviedesc_screen.dart';

// Custom GradientText widget for styled text
class GradientText extends StatelessWidget {
  final String text;
  final Gradient gradient;
  final TextStyle style;

  GradientText({
    required this.text,
    required this.gradient,
    this.style = const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(bounds),
      child: Text(
        text,
        style: style.copyWith(color: Colors.white),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  // Movie list for now playing
// Now Playing Movies
final List<Movie> nowPlayingMovies = [
  Movie(
    title: "The Nun II",
    genre: "Horror",
    releaseYear: 2023,
    director: "Michael Chaves",
    cast: ["Taissa Farmiga", "Storm Reid"],
    description: "1956 - France. A priest is murdered...",
    imageUrl: "images/The Nun II.jpeg",
    trailerUrl: "https://youtu.be/QF-oyCwaArU?feature=shared",
    MTRCBrating: 4.5, // Provide a rating
  ),
  Movie(
    title: "Harold and the Purple Crayon",
    genre: "Animation",
    releaseYear: 2023,
    director: "Carla Marsh",
    cast: ["Zach Tyler", "Lacey Chabert"],
    description: "Based on the beloved children's book series...",
    imageUrl: "images/Harold and the Purple Crayon.jpeg",
    trailerUrl: "https://www.youtube.com/watch?v=trailer_id2",
    MTRCBrating: 4.0, // Provide a rating
  ),
  Movie(
    title: "UnHappy For You",
    genre: "Comedy",
    releaseYear: 2023,
    director: "George Thomas",
    cast: ["Emily Blunt", "John Krasinski"],
    description: "A comedy about the trials and tribulations...",
    imageUrl: "images/UnHappy For You.jpeg",
    trailerUrl: "https://www.youtube.com/watch?v=trailer_id3",
    MTRCBrating: 3.5, // Provide a rating
  ),
];

final List<Movie> upcomingMovies = [
  Movie(
    title: "Transformers One",
    genre: "Action",
    releaseYear: 2024,
    director: "Steven Caple Jr.",
    cast: ["Anthony Ramos", "Dominique Fishback"],
    description: "The next installment in the Transformers franchise...",
    imageUrl: "images/Transformers One.jpeg",
    trailerUrl: "https://www.youtube.com/watch?v=trailer_id4",
    MTRCBrating: 4.8, // Provide a rating
  ),
];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: GradientText(
          text: "CineSphere",
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(134, 162, 145, 100),
              Color.fromRGBO(177, 196, 185, 100),
              Color.fromRGBO(78, 106, 89, 100),
            ],
            end: Alignment.bottomRight,
          ),
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Now Showing Section
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Now Showing",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 300,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: nowPlayingMovies.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MovieDescScreen(
                                  movie: nowPlayingMovies[index],
                                ),
                              ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              color: Colors.white,
                              child: Image.asset(
                                nowPlayingMovies[index].imageUrl,
                                fit: BoxFit.cover,
                                height: 200,
                                width: 150,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            color: const Color.fromARGB(255, 13, 17, 15).withOpacity(0.6),
                            padding: EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  nowPlayingMovies[index].title,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Color(0xFFF7D300),
                                    ),
                                    Text(
                                      "4.5",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFFF7D300),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.access_time_rounded,
                                      color: Colors.white60,
                                      size: 20,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      "6h 3min",
                                      style: TextStyle(
                                        color: Colors.white60,
                                        fontSize: 16,
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
                },
              ),
            ),
            // Upcoming Movies Section
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Upcoming Movies",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 300,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: upcomingMovies.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MovieDescScreen(
                                  movie: upcomingMovies[index],
                                ),
                              ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              color: Colors.white,
                              child: Image.asset(
                                upcomingMovies[index].imageUrl,
                                fit: BoxFit.cover,
                                height: 200,
                                width: 150,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            color: const Color.fromARGB(255, 13, 17, 15).withOpacity(0.6),
                            padding: EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  upcomingMovies[index].title,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Color(0xFFF7D300),
                                    ),
                                    Text(
                                      "4.5",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFFF7D300),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.access_time_rounded,
                                      color: Colors.white60,
                                      size: 20,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      "6h 3min",
                                      style: TextStyle(
                                        color: Colors.white60,
                                        fontSize: 16,
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
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.green,
        onTap: (int index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FavoritesScreen(),
              ),
            );
          }
        },
      ),
    );
  }
}
