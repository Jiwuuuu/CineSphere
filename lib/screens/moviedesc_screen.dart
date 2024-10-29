import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cinesphere/screens/movie.dart';
import 'package:cinesphere/favorites_manager.dart';
import 'package:cinesphere/screens/booking.dart';
import 'package:cinesphere/database/supabase_service.dart';
import 'package:google_fonts/google_fonts.dart';

final supabaseClient = SupabaseService().client;

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
  }

  void _toggleDescription() {
    setState(() {
      isDescriptionExpanded = !isDescriptionExpanded;
    });
  }

  Future<void> _launchTrailer() async {
    final Uri url = Uri.parse(widget.movie.trailer_link);
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
      backgroundColor: Color(0xFF07130E),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 400,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.movie.poster_url),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    left: 20,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_back,
                            color: Color(0xFF8CDDBB),
                            shadows: [
                              Shadow(
                                offset: Offset(2.0, 2.0),
                                blurRadius: 4.0,
                                color: Colors.black,
                              ),
                            ],
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Back',
                            style: GoogleFonts.lexend(
                              color: Color(0xFF8CDDBB),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              shadows: [
                                Shadow(
                                  offset: Offset(2.0, 2.0),
                                  blurRadius: 4.0,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.movie.title,
                      style: GoogleFonts.lexend(
                        color: Color(0xFF8CDDBB),
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      isDescriptionExpanded
                          ? widget.movie.description
                          : (widget.movie.description.length > 100
                              ? widget.movie.description.substring(0, 100) + '...'
                              : widget.movie.description),
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.lexend(
                        color: Color(0xFFE2F1EB),
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    if (widget.movie.description.length > 100)
                      GestureDetector(
                        onTap: _toggleDescription,
                        child: Text(
                          isDescriptionExpanded ? 'Read Less' : 'Read More',
                          style: GoogleFonts.lexend(
                            color: Color(0xFFE2F1EB),
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    SizedBox(height: 10),
                    _buildMovieDetailRow('Genre', widget.movie.genre),
                    _buildMovieDetailRow('Director', widget.movie.director),
                    _buildMovieDetailRow('Cast', widget.movie.cast.join(', ')),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Icon(
                          Icons.play_circle_fill,
                          color: Color(0xFFE2F1EB),
                          size: 30,
                        ),
                        SizedBox(width: 8),
                        GestureDetector(
                          onTap: _launchTrailer,
                          child: Text(
                            'Watch Trailer',
                            style: GoogleFonts.lexend(
                              color: Color(0xFFE2F1EB),
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    // Conditionally render the "Book Now" button based on the movie's status
                    if (widget.movie.status != 'Coming Soon')
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BookingScreen(movie: widget.movie),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF8CDDBB),
                            padding: EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 16,
                            ),
                            textStyle: GoogleFonts.lexend(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                          ),
                          child: Text(
                            'Book Now',
                            style: GoogleFonts.lexend(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMovieDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$label: ',
              style: GoogleFonts.lexend(
                color: Color(0xFF8CDDBB),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: value,
              style: GoogleFonts.lexend(
                color: Color(0xFFE2F1EB),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
