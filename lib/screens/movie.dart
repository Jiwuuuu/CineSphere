class Movie {
  final String title;
  final String genre;
  final int releaseYear;
  final String director;
  final List<String> cast;
  final String description;
  final String imageUrl;
  final String trailerUrl;
  final double MTRCBrating; // Assuming it's a double

  Movie({
    required this.title,
    required this.genre,
    required this.releaseYear,
    required this.director,
    required this.cast,
    required this.description,
    required this.imageUrl,
    required this.trailerUrl,
    required this.MTRCBrating, // Required parameter
  });
}
