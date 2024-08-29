
import 'package:cinesphere/screens/moviedesc_screen.dart';
import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/services.dart';
import 'package:cinesphere/main.dart';

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


class HomeScreen extends StatelessWidget{
 List movies = [
  "The Nun II",
  "Harold and the Purple Crayon",
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
            colors: [Color.fromRGBO(134, 162, 145, 100), Color.fromRGBO(177, 196, 185, 100) , Color.fromRGBO(78, 106, 89, 100)],
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Now Playing",
                    style: TextStyle(
                      color: text_color,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      "View All",
                      style: TextStyle(
                        color: text_color,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
  height: 683,
  child: GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 20, 
      mainAxisSpacing: 20, 
      childAspectRatio: 0.6, 
    ),
    itemCount: movies.length,
    itemBuilder: (context, index) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 30), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieDesc_screen(movie: movies[index]),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  color: Colors.white,
                  child: Image.asset(
                    "images/${movies[index]}.jpeg",
                    fit: BoxFit.cover,
                    height: 200,
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8), 
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movies[index],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: text_color,
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
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}