part of 'movies_bloc.dart';

abstract class MoviesEvent {}

class FirstMoviesEvent extends MoviesEvent {}

class IncreasePageMoviesEvent extends MoviesEvent {}

class DecreasePageMoviesEvent extends MoviesEvent {}

class SearchPageMoviesEvent extends MoviesEvent {}
