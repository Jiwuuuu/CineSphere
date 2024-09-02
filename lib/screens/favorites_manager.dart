
class FavoritesManager {
  // Singleton pattern for managing favorites
  FavoritesManager._privateConstructor();
  static final FavoritesManager instance = FavoritesManager._privateConstructor();

  final Set<String> _favorites = <String>{};

  bool isFavorite(String movieTitle) => _favorites.contains(movieTitle);

  void addMovie(String movieTitle) {
    _favorites.add(movieTitle);
  }

  void removeMovie(String movieTitle) {
    _favorites.remove(movieTitle);
  }
}