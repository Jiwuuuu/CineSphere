import 'package:cinesphere/database/supabase_service.dart';
import 'package:cinesphere/main.dart';
import 'package:flutter/material.dart';
import 'package:cinesphere/screens/movie.dart';
import 'package:cinesphere/screens/moviedesc_screen.dart';
import 'package:cinesphere/screens/favorites_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart'; // Add this package for carousel functionality

final supabaseClient = SupabaseService().client;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this); // 3 tabs
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg_color,
      appBar: AppBar(
  backgroundColor: bg_color,
  elevation: 0,
  title: Row(
    mainAxisAlignment: MainAxisAlignment.center, // Center the Row contents
    mainAxisSize: MainAxisSize.min, // Take only the necessary space
    children: [
      Image.asset(
        'images/Logo.png', // Replace with your image path
        height: 30, // Adjust the size of the logo
      ),
      const SizedBox(width: 10), // Add some spacing between the logo and text
      Text(
        "CINESPHERE",
        style: GoogleFonts.lexend(
          fontWeight: FontWeight.bold,
          color: header_text,
          fontSize: 30,
        ),
      ),
    ],
  ),
  centerTitle: true, // Keeps the title centered
  bottom: TabBar(
    controller: _tabController,
    tabs: const [
      Tab(text: 'Now Showing'),
      Tab(text: 'Advance Selling'),
      Tab(text: 'Coming Soon'),
    ],
    labelColor: header_text,
    unselectedLabelColor: Colors.grey,
    dividerColor: Colors.transparent,
    indicator: const UnderlineTabIndicator(
      borderSide: BorderSide(
        color: header_text, // Set your desired color here
        width: 2.0, // Set the thickness of the underline
      ),
    ),
  ),
),
      body: FutureBuilder<List<Movie>>(
        future: fetchMovies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No movies found.'));
          }

          final List<Movie> movies = snapshot.data!;

          final List<Movie> nowPlayingMovies = movies.where((movie) => movie.status == 'Now Showing').toList();
          final List<Movie> upcomingMovies = movies.where((movie) => movie.status == 'Coming Soon').toList();
          final List<Movie> advanceSellingMovies = movies.where((movie) => movie.status == 'Advance Selling').toList();

          return TabBarView(
            controller: _tabController,
            children: [
              _buildCarouselSection(nowPlayingMovies, context),
              _buildCarouselSection(advanceSellingMovies, context),
              _buildCarouselSection(upcomingMovies, context),
            ],
          );
        },
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: Color(0xFF07130E),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0x3D40E49F),
              blurRadius: 4,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildBottomBarItem(Icons.favorite_outline, 'Favorites', () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritesScreen(),
                ),
              );
            }),
            _buildBottomBarItem(Icons.home_outlined, 'Home', () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              );
            }),
            _buildBottomBarItem(Icons.receipt_long_rounded, 'Transaction', () {
              // Implement notifications functionality if needed
            }),
          ],
        ),
      ),
    );
  }

  Future<List<Movie>> fetchMovies() async {
    try {
      final response = await supabaseClient
          .from('movies') // Your Supabase table name
          .select();

      final List<Movie> movies = response.map((item) {
        return Movie(
          title: item['title'],
          genre: item['genre'],
          director: item['director'],
          cast: List<String>.from(item['cast']),
          mtrcb_rating: item['mtrcb_rating'],
          description: item['description'],
          poster_url: item['poster_url'],
          trailer_link: item['trailer_link'],
          status: item['status'],
        );
      }).toList();

      return movies;
    } catch (error) {
      throw Exception('Failed to load movies: $error');
    }
  }

  Widget _buildBottomBarItem(IconData icon, String label, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: icon_color),
          SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              color: text,
              fontSize: 12,
              fontFamily: 'Lexend Deca',
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

Widget _buildCarouselSection(List<Movie> movies, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(left: 0, top: 50),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CarouselSlider(
          items: movies.map((movie) {
            return Builder(
              builder: (BuildContext context) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDescScreen(movie: movie),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 400,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(movie.poster_url.isEmpty
                                ? 'images/default_image_url.jpg'
                                : movie.poster_url),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      SizedBox(height: 8), // Space between poster and title
                      Text(
                        truncateTitle(movie.title, maxLength: 15),
                        style: GoogleFonts.lexend(
                          color: text,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4), // Space between title and description
                      Container(
                        height: 60, // Fixed height for description
                        alignment: Alignment.center,
                        child: Text(
                          movie.description,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lexend(
                            color: text,
                            fontSize: 14,
                          ),
                          maxLines: 3, // Limit to 3 lines
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: 10), // Space between description and genre
                      Container(
                        height: 20, // Fixed height for genre to prevent overflow
                        child: Text(
                          movie.genre,
                          style: GoogleFonts.lexend(
                            color: text,
                            fontSize: 12,
                          ),
                          maxLines: 1, // Limit to 1 line
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }).toList(),
          options: CarouselOptions(
            height: 530,
            enlargeCenterPage: true,
            autoPlay: true,
            enableInfiniteScroll: true,
            aspectRatio: 16 / 9,
            initialPage: 0,
          ),
        ),
      ],
    ),
  );
}




  String truncateTitle(String title, {int maxLength = 15}) {
    if (title.length > maxLength) {
      return '${title.substring(0, maxLength)}...';
    }
    return title;
  }
}
