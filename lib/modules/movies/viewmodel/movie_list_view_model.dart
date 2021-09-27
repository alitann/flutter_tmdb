import '../services/movie_data_service.dart';

import 'movie_view_model.dart';

class MovieListViewModel {
  List<MovieViewModel>? movies = [];

  Future<List<MovieViewModel>> getMovies({int pageNumber = 1}) async {
    final apiResult =
        await MovieDataService().getMovies(pageNumber: pageNumber);
    movies = apiResult.map((e) => MovieViewModel(e)).toList();
    return movies ?? [];
  }
}
