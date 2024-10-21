import 'package:cinesphere/database/supabase_service.dart';
import 'package:cinesphere/main.dart';
import 'package:flutter/material.dart';
import 'package:cinesphere/screens/movie.dart';
import 'package:cinesphere/screens/moviedesc_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart'; // Add this package for carousel functionality
import 'package:cached_network_image/cached_network_image.dart';

final supabaseClient = SupabaseService().client;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
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
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'images/Logo.png',
              height: 30,
            ),
            const SizedBox(width: 10),
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
        centerTitle: true,
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
              color: header_text,
              width: 2.0,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          FutureBuilder<List<Movie>>(
            future: fetchMovies(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: \${snapshot.error}'));
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
          // 2. Floating bottom navigation bar
          Positioned(
            bottom: 20, // Adjust distance from the bottom
            left: MediaQuery.of(context).size.width * 0.1, // Center it horizontally
            right: MediaQuery.of(context).size.width * 0.1,
            child: BottomNavBar(), // New floating bottom navigation bar
          ),
        ],
      ),
    );
  }

  Future<List<Movie>> fetchMovies() async {
    try {
      final response = await supabaseClient.from('movies').select();


      final List<Movie> movies = response.map((item) {
        return Movie(
          id: item['id'] ?? '',
          title: item['title'] ?? 'Unknown Title',
          genre: item['genre'] ?? 'Unknown Genre',
          director: item['director'] ?? 'Unknown Director',
          cast: item['cast'] != null ? List<String>.from(item['cast']) : [],
          mtrcb_rating: item['mtrcb_rating'] ?? 'Unrated',
          description: item['description'] ?? 'No description available.',
          poster_url: item['poster_url'] ?? 'images/default_image_url.jpg',
          trailer_link: item['trailer_link'] ?? '',
          status: item['status'] ?? 'Unknown',
        );
      }).toList();

      return movies;
    } catch (error) {
      throw Exception('Failed to load movies: \$error');
    }
  }

Widget _buildCarouselSection(List<Movie> movies, BuildContext context) {
  double screenHeight = MediaQuery.of(context).size.height;
  double carouselHeight = screenHeight > 800 ? 700 : 600;
  double posterHeight = screenHeight > 800 ? 395 : 350;

  return Padding(
    padding: const EdgeInsets.only(left: 0, top: 35),
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
                        height: posterHeight,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            movie.poster_url.isEmpty
                                ? 'images/default_image_url.jpg'
                                : movie.poster_url,
                          ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      const SizedBox(height: 8),
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
                      const SizedBox(height: 4),
                      Container(
                        height: 60,
                        alignment: Alignment.center,
                        child: Text(
                          movie.description,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lexend(
                            color: text,
                            fontSize: 14,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        height: 20, // Fixed height for genre to prevent overflow
                        child: Text(
                          movie.genre,
                          style: GoogleFonts.lexend(
                            color: header_text,
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
            height: carouselHeight,
            enlargeCenterPage: true,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
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
      return '\${title.substring(0, maxLength)}...';
    }
    return title;
  }
}

// Floating bottom navigation bar widget
class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double containerWidth = screenWidth * 0.8;

    return Container(
      width: containerWidth,
      height: 70,
      child: Stack(
        children: [
          // The shadow box
          Container(
            width: containerWidth,
            height: 70,
            decoration: ShapeDecoration(
              color: bg_color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              shadows: [
                BoxShadow(
                  color: Color(0x3D40E49F),
                  blurRadius: 18.4,
                  offset: Offset(0, 0),
                  spreadRadius: 2.0,
                ),
                BoxShadow(
                  color: Colors.greenAccent.withOpacity(0.3),
                  blurRadius: 10,
                  offset: Offset(0, 0),
                ),
              ],
            ),
          ),
          // Icons as images
          Positioned(
            left: containerWidth * 0.1,
            top: 24,
            child: GestureDetector(
              onTap: () {
                // Navigate to favorites
              },
              child: Image.asset(
                'images/icons/favourite.png',
                width: 22,
                height: 22,
              ),
            ),
          ),
          Positioned(
            left: containerWidth * 0.45,
            top: 24,
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
              },
              child: Image.asset(
                'images/icons/home.png',
                width: 22,
                height: 22,
              ),
            ),
          ),
          Positioned(
            left: containerWidth * 0.8,
            top: 24,
            child: GestureDetector(
              onTap: () {
                // navigate to transactions
              },
              child: Image.asset(
                'images/icons/transaction.png',
                width: 22,
                height: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
