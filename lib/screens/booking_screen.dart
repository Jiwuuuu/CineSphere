import 'package:flutter/material.dart';

class BookingScreen extends StatelessWidget {
 String movie;
 BookingScreen({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF212429),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2.2,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    image: DecorationImage(
                      image: AssetImage("images/${movie}.jpeg"),
                      fit: BoxFit.cover,
                      opacity: 0.8,
                    ),
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
                      Icon(
                        Icons.favorite_outline,
                        color: Colors.white,
                        size: 25,
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
                    movie,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "69h 30min • 2022",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white60,
                        fontWeight: FontWeight.normal,
                      ),
                  ),
                Container(
                padding: EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 51, 57, 52).withOpacity(0.9),
                    borderRadius: BorderRadius.circular(10),
                ),
                child: Text("horror",
                style: TextStyle(
                  color: const Color.fromARGB(255, 134, 124, 124),
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                        ),
                      )  
                    
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