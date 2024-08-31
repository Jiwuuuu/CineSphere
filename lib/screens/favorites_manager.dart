class FavoritesManager {
  // Private constructor
  FavoritesManager._privateConstructor();

  // Singleton instance
  static final FavoritesManager instance = FavoritesManager._privateConstructor();

  // List to store favorite movies
  final List<String> _favoriteMovies = [];

  List<String> get favoriteMovies => _favoriteMovies;

  void addMovie(String movie) {
    if (!_favoriteMovies.contains(movie)) {
      _favoriteMovies.add(movie);
    }
  }

  void removeMovie(String movie) {
    _favoriteMovies.remove(movie);
  }

  bool isFavorite(String movie) {
    return _favoriteMovies.contains(movie);
  }
}