class Movie {
  final String id; // Added movie ID
  final String title;
  final String genre;
  final String director;
  final List<String> cast;
  final String mtrcb_rating;
  final String description;
  final String poster_url;
  final String trailer_link;
  final String status; // New field for movie status

  Movie({
    required this.id, // Added required movie ID
    required this.title,
    required this.genre,
    required this.director,
    required this.cast,
    required this.mtrcb_rating,
    required this.description,
    required this.poster_url,
    required this.trailer_link,
    required this.status,
  });

  // Factory constructor to create a Movie instance from a map
  factory Movie.fromMap(Map<String, dynamic> movieData) {
    return Movie(
      id: movieData['id'], // Added ID from map
      title: movieData['title'],
      genre: movieData['genre'],
      director: movieData['director'],
      cast: List<String>.from(movieData['cast']),
      mtrcb_rating: movieData['mtrcb_rating'],
      description: movieData['description'],
      poster_url: movieData['poster_url'],
      trailer_link: movieData['trailer_link'],
      status: movieData['status'],
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Movie &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
