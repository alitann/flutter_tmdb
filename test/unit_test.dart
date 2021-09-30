import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tmdb/core/constants/application_constants.dart';
import 'package:flutter_tmdb/modules/movies/bloc/movies_bloc.dart';
import 'package:flutter_tmdb/modules/movies/models/movie.dart';
import 'package:flutter_tmdb/modules/movies/viewmodel/movie_list_view_model.dart';
import 'package:flutter_tmdb/modules/movies/viewmodel/movie_view_model.dart';

void main() {
  MovieListViewModel movieListViewModel = MovieListViewModel();
  // MockMoviesBloc mockMoviesBloc = MockMoviesBloc();

  // MockMovieListRepository movieListRepository = MockMovieListRepository();

  Movie movie = Movie(
      adult: false,
      backdropPath: "/8Y43POKjjKDGI9MH89NW0NAzzp8.jpg",
      genreIds: [35, 28, 12, 878],
      id: 550988,
      originalLanguage: "en",
      originalTitle: "Free Guy",
      overview:
          "A bank teller called Guy realizes he is a background character in an open world video game called Free City that will soon go offline.",
      popularity: 5418.816,
      posterPath: "/xmbU4JTUm8rsdtn7Y3Fcm30GpeT.jpg",
      releaseDate: "2021-08-11",
      title: "Free Guy",
      video: false,
      voteAverage: 7.9,
      voteCount: 1312);

  setUp(() {});

  tearDown(() {
    movieListViewModel.movies!.clear();
  });

  group("movieListViewModel features manuel", () {
    test("initializes with empty", () {
      expect(movieListViewModel.movies?.length, 0);
    });

    test("Movie added", () {
      movieListViewModel.movies!.add(
        MovieViewModel(movie),
      );

      expect(movieListViewModel.movies?.length, 1);
      expect(movieListViewModel.movies![0].movie.originalTitle, "Free Guy");
      expect(
          movieListViewModel.movies![0].posterImageUrl,
          ApplicationConstants.imageBaseUrl.toString() +
              movieListViewModel.movies![0].movie.posterPath.toString());
    });
  });

  group('MovieViewModel getMovies', () {
    test('getMovies', () {
      Future<List<MovieViewModel>> movies;
      movies = movieListViewModel.getMovies(pageNumber: 1);

      movies.then((value) {
        List<MovieViewModel> result = value;
        String name = result.first.movie.originalTitle.toString();
        expect(name, "Free Guy");
        expect(result.length, 20);
      });
    });
  });

  group('MoviesBloc', () {
    blocTest(
      'emits [initial] when nothing is added',
      build: () => MoviesBloc(movieListViewModel: movieListViewModel),
      expect: () => [],
    );

    blocTest<MoviesBloc, MoviesState>(
      'emits [LoadingMoviesState] when FirstMoviesEvent is added',
      build: () => MoviesBloc(movieListViewModel: movieListViewModel),
      act: (bloc) => bloc.add(FirstMoviesEvent()),
      expect: () => [isA<LoadingMoviesState>()],
    );

    blocTest<MoviesBloc, MoviesState>(
      'emits [SearchedMoviesState] when SearchPageMoviesEvent is added',
      build: () => MoviesBloc(movieListViewModel: movieListViewModel),
      act: (bloc) => bloc.add(SearchPageMoviesEvent()),
      //wait: const Duration(milliseconds: 10000),
      expect: () => [isA<SearchedMoviesState>()],
    );

    blocTest<MoviesBloc, MoviesState>(
      'emits [LoadingMoviesState] when IncreasePageMoviesEvent is added',
      build: () => MoviesBloc(movieListViewModel: movieListViewModel),
      act: (bloc) => bloc.add(IncreasePageMoviesEvent()),
      expect: () => [isA<LoadingMoviesState>()],
    );
  });
}
