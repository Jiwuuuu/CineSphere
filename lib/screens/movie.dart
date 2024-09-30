class Movie {
  final String title;
  final String genre;
  final String releaseYear;
  final String director;
  final List<String> cast;
  final String MTRCBrating;
  final String description;
  final String imageUrl;
  final String trailerUrl;

  Movie({
    required this.title,
    required this.genre,
    required this.releaseYear,
    required this.director,
    required this.cast,
    required this.MTRCBrating,
    required this.description,
    required this.imageUrl,
    required this.trailerUrl,
  });
}