import '../models/movie_service_response.dart';
import '../services/api_service.dart';
import '../services/movie_data_service.dart';
import 'movie_view_model.dart';

class MovieListViewModel {
  final ApiService apiService;
  List<MovieViewModel>? movies = [];

  MovieListViewModel(this.apiService);

  //retrofit approach
  Future<List<MovieViewModel>> getMovies({int pageNumber = 1}) async {
    final MovieServiceResponse apiResult =
        await apiService.getMovies(pageNumber);
    movies = apiResult.results?.map((e) => MovieViewModel(e)).toList();
    return movies ?? [];
  }

  //http network service
  // you can change getMoviesHttp --> getMovies and you can use like this without retrofit approach.
  //If you want to this approach, you must close above getMovies function or rename and you must reinput main page  in MoviesBloc in BlocProvider
  Future<List<MovieViewModel>> getMoviesHttp({int pageNumber = 1}) async {
    final apiResult =
        await MovieDataService().getMovies(pageNumber: pageNumber);
    movies = apiResult.map((e) => MovieViewModel(e)).toList();
    return movies ?? [];
  }
}
