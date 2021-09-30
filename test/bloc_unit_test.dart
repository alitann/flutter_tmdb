import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tmdb/modules/movies/bloc/movies_bloc.dart';
import 'package:flutter_tmdb/modules/movies/models/movie.dart';
import 'package:flutter_tmdb/modules/movies/viewmodel/movie_list_view_model.dart';
import 'package:flutter_tmdb/modules/movies/viewmodel/movie_view_model.dart';
import 'package:mockito/mockito.dart';

class MockMoviesRepository extends Mock implements MovieListViewModel {}

void main() {
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

  List<MovieViewModel> movies = [];
  movies.add(MovieViewModel(movie));

  group('MovieBloc', () {
    MovieListViewModel movieRepository;
    MoviesBloc movieBloc;

    movieRepository = MockMoviesRepository();
    movieBloc = MoviesBloc(movieListViewModel: movieRepository);

    // test('throws AssertionError if MovieRepository is null', () {
    //   expect(
    //     () => MoviesBloc(movieListViewModel: null),
    //     throwsA(isAssertionError),
    //   );
    // });

    group('MovieRequested', () {
      blocTest<MoviesBloc, MoviesState>(
        'emits [MoviesState] when FirstMoviesEvent is added and getMovie succeeds',
        build: () {
          when(movieRepository.getMovies(pageNumber: 1)).thenAnswer(
            (_) => Future.value(movies),
          );
          return movieBloc;
        },
        act: (bloc) => bloc.add(FirstMoviesEvent()),
        expect: () => [
          LoadingMoviesState(),
          LoadedMoviesState(movies: movies),
        ],
      );

      blocTest<MoviesBloc, MoviesState>(
        'emits [LoadingMoviesState, FailedMoviesState] when MovieRequested is added and getMovie fails',
        build: () {
          when(movieRepository.getMovies(pageNumber: 1)).thenThrow('error');
          return movieBloc;
        },
        act: (bloc) => bloc.add(IncreasePageMoviesEvent()),
        expect: () => [
          LoadingMoviesState(),
          FailedMoviesState(errorMessage: 'error'),
        ],
      );
    });
  });
}
