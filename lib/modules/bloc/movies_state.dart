part of 'movies_bloc.dart';

abstract class MoviesState {}

class LoadingMovies extends MoviesState {}

class FailedMovies extends MoviesState {}

class LoadedMovies extends MoviesState {}
