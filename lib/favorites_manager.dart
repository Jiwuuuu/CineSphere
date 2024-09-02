class FavoritesManager {
  // Singleton instance
  static final FavoritesManager _instance = FavoritesManager._internal();

  // List to store favorite movies
  final List<String> _favoriteMovies = [];

  // Private constructor
  FavoritesManager._internal();

  // Factory constructor to return the singleton instance
  factory FavoritesManager() => _instance;

  // Access to the singleton instance
  static FavoritesManager get instance => _instance;

  // Getter for favorite movies
  List<String> get favoriteMovies => List.unmodifiable(_favoriteMovies);

  // Method to add a movie to favorites
  void addMovie(String movie) {
    if (!_favoriteMovies.contains(movie)) {
      _favoriteMovies.add(movie);
    }
  }

  // Method to remove a movie from favorites
  void removeMovie(String movie) {
    _favoriteMovies.remove(movie);
  }

  // Check if a movie is in favorites
  bool isFavorite(String movie) {
    return _favoriteMovies.contains(movie);
  }

  void removeFavorite(String movie) {}

  void addFavorite(String movie) {}
}