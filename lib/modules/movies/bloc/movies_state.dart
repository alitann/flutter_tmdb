part of 'movies_bloc.dart';

abstract class MoviesState {}

class InitialMoviesState extends MoviesState {}

class LatestPageNumberMoviesState extends MoviesState {
  final int pageNumber;

  LatestPageNumberMoviesState(this.pageNumber);
}

class LoadingMoviesState extends MoviesState {}

class FailedMoviesState extends MoviesState {
  String errorMessage;
  FailedMoviesState({
    required this.errorMessage,
  });
}

class LoadedMoviesState extends MoviesState {
  List<MovieViewModel> movies;
  LoadedMoviesState({
    required this.movies,
  });
}

class SearchedMoviesState extends MoviesState {
  List<MovieViewModel> movies;
  SearchedMoviesState({
    required this.movies,
  });
}
