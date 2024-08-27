import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      home: Scaffold(

        appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: const Text('CineSphere wtf'),
        ),

        body: Container(
          
        ),
      )
    );
  }
}