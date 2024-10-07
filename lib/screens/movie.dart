class Movie {
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
    required this.title,
    required this.genre,
    required this.director,
    required this.cast,
    required this.mtrcb_rating,
    required this.description,
    required this.poster_url,
    required this.trailer_link,
    required this.status, // Required status field
  });

  // Factory constructor to create a Movie instance from a map
  factory Movie.fromMap(Map<String, dynamic> movieData) {
    return Movie(
      title: movieData['title'],
      genre: movieData['genre'],
      director: movieData['director'],
      cast: List<String>.from(movieData['cast']),
      mtrcb_rating: movieData['mtrcb_rating'],
      description: movieData['description'],
      poster_url: movieData['poster_url'],
      trailer_link: movieData['trailer_link'],
      status: movieData['status'], // Status added here
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Movie &&
          runtimeType == other.runtimeType &&
          title == other.title;

  @override
  int get hashCode => title.hashCode;
}
