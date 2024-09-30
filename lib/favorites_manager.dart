class FavoritesManager {
  static final FavoritesManager _instance = FavoritesManager._internal();

  factory FavoritesManager() {
    return _instance;
  }

  FavoritesManager._internal();

  final List<String> _favorites = [];

  static FavoritesManager get instance => _instance;

  get favoriteMovies => null;

  void addMovie(String title) {
    if (!_favorites.contains(title)) {
      _favorites.add(title);
    }
  }

  void removeMovie(String title) {
    _favorites.remove(title);
  }

  bool isFavorite(String title) {
    return _favorites.contains(title);
  }

  // Add this method
  void addMovieToFavorites(String title) {
    addMovie(title); // You can call the existing addMovie method if it does the same thing
  }
}