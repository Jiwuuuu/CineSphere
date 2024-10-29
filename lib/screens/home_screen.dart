import 'package:cinesphere/database/supabase_service.dart';
import 'package:cinesphere/main.dart';
import 'package:cinesphere/screens/more_screen.dart';
import 'package:flutter/material.dart';
import 'package:cinesphere/screens/movie.dart';
import 'package:cinesphere/screens/moviedesc_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinesphere/screens/ticket_screen.dart';
import 'package:lottie/lottie.dart';  // Import Lottie

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
  int _currentIndex = 1; // To keep track of the current index in the navigation bar (1 = Home Screen)

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
                return Center(
                  child: Lottie.asset(
                    'assets/animations/loading_animation.json',  // Path to your Lottie animation file
                    width: 150,
                    height: 150,
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Error: ${snapshot.error}',
                    style: TextStyle(color: header_text),
                  ),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                  child: Text(
                    'No movies found.',
                    style: TextStyle(color: header_text),
                  ),
                );
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
            child: BottomNavBar(
              currentIndex: _currentIndex,
              onTabChange: (index) {
                setState(() {
                  _currentIndex = index;
                  // Handle navigation to different screens based on the index
                  if (_currentIndex == 1) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  } else if (_currentIndex == 0) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TicketScreen()),
                    );
                  } else if (_currentIndex == 2) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MoreScreen()),
                    );
                  }
                });
              },
            ), // Updated floating bottom navigation bar
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
          price: item['price'] ?? 500,
        );
      }).toList();

      return movies;
    } catch (error) {
      throw Exception('Failed to load movies: $error');
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
                          movie.title,
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
}

// Updated floating bottom navigation bar widget with indication line
// Floating bottom navigation bar widget
class BottomNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTabChange;

  BottomNavBar({required this.currentIndex, required this.onTabChange});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
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
          // Ticket Icon (Left Button)
          Positioned(
            left: containerWidth * 0.1,
            top: 24,
            child: GestureDetector(
              onTap: () {
                widget.onTabChange(0);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TicketScreen()),
                );
              },
              child: Column(
                children: [
                  Image.asset(
                    'images/icons/tickets.png',
                    width: 22,
                    height: 22,
                  ),
                  if (widget.currentIndex == 0)
                    Container(
                      margin: EdgeInsets.only(top: 2),
                      height: 3,
                      width: 22,
                      color: Color(0xFF8CDDBB),
                    ),
                ],
              ),
            ),
          ),
          // Home Icon (Center Button)
          Positioned(
            left: containerWidth * 0.45,
            top: 24,
            child: GestureDetector(
              onTap: () {
                widget.onTabChange(1);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
              },
              child: Column(
                children: [
                  Image.asset(
                    'images/icons/home.png',
                    width: 22,
                    height: 22,
                  ),
                  if (widget.currentIndex == 1)
                    Container(
                      margin: EdgeInsets.only(top: 2),
                      height: 3,
                      width: 22,
                      color: Color(0xFF8CDDBB),
                    ),
                ],
              ),
            ),
          ),
          // More Icon (Right Button)
          Positioned(
            left: containerWidth * 0.8,
            top: 24,
            child: GestureDetector(
              onTap: () {
                widget.onTabChange(2);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MoreScreen()),
                );
              },
              child: Column(
                children: [
                  Image.asset(
                    'images/icons/more.png',
                    width: 22,
                    height: 22,
                  ),
                  if (widget.currentIndex == 2)
                    Container(
                      margin: EdgeInsets.only(top: 2),
                      height: 3,
                      width: 22,
                      color: Color(0xFF8CDDBB),
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
