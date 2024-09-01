import 'package:flutter/material.dart';
import 'package:cinesphere/screens/moviedesc_screen.dart';
import 'package:cinesphere/screens/favorites_screen.dart'; // Import your FavoritesScreen
import 'package:cinesphere/main.dart';
import 'package:cinesphere/favorites_manager.dart'; // Import the FavoritesManager

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
  final List<String> nowPlayingMovies = [
    "The Nun II",
    "Harold and the Purple Crayon",
    "UnHappy For You"
  ];

  final List<String> upcomingMovies = [
    "Transformers One",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg_color,
      appBar: AppBar(
        backgroundColor: bg_color,
        elevation: 0,
        title: GradientText(
          text: "CineSphere",
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(134, 162, 145, 100),
              Color.fromRGBO(177, 196, 185, 100),
              Color.fromRGBO(78, 106, 89, 100)
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
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Now Showing",
                    style: TextStyle(
                      color: text_color,
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
                                "images/${nowPlayingMovies[index]}.jpeg",
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
                                  nowPlayingMovies[index],
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
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Upcoming Movies",
                    style: TextStyle(
                      color: text_color,
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
                                "images/${upcomingMovies[index]}.jpeg",
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
                                  upcomingMovies[index],
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
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.favorite, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavoritesScreen(),
                  ),
                );
              },
            ),
            Spacer(), // Pushes the next button to the center
            IconButton(
              icon: Icon(Icons.home, color: Colors.white),
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/')); // Navigate to HomeScreen
              },
            ),
            Spacer(), // Pushes the next button to the center
            IconButton(
              icon: Icon(Icons.notifications, color: Colors.white),
              onPressed: () {
                // Handle notifications button press
                // Navigate to NotificationsScreen or show notifications
              },
            ),
          ],
        ),
      ),
    );
  }
}