class ApplicationConstants {
  //to get Popular Movies
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String discoverPath = '/discover/movie';
  static const String apiKeyParameter = '?api_key=';
  static const String apiKey = '4ff9d08260ed338797caa272d7df35dd';

  //to get image for selected movie
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/original';

  //Easy Localization
  static const String languageAssetPath = 'assets/translations';

  //Api total_pages can be max 500
  static const int apiTotalPagesNumber = 500;
}
