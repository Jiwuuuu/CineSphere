import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
        style: style.copyWith(color: Colors.white), // Base color for text is white
      ),
    );
  }
}


class HomeScreen extends StatelessWidget{
 List movies = [
  "harold",
  "harold",
  "harold",
  "harold",
  "harold",
  "harold",
  "harold",
  "harold"
 
 ];
  List movies2  = [
  "harold",
  "harold",
  "harold",
  "harold",
  "harold",
  "harold",
  "harold"
  ];
  
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        elevation: 0,
        title: GradientText(
          text: "CineSphere",
          gradient: LinearGradient(
            colors: [Colors.green, Colors.blue], // Gradient colors
            begin: Alignment.topLeft,
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
              Padding(padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Now Playing",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  InkWell(
                    onTap: (){},
                    child: Text(
                      "View All",
                      style: TextStyle(
                      color: Color(0xFFF7D300),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
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
                  crossAxisSpacing: 0,  
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.75,
                ),
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              color: Colors.white,
                              child: Image.asset(
                                "images/${movies[index]}.jpeg",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 8), 
                        Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0),
                        child: Text(
                          movies[index],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            overflow: TextOverflow.ellipsis,
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
        );   
  }
}