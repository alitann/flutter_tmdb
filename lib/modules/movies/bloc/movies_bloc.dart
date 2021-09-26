import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/services/movie_data_service.dart';
import '../models/movie.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final _dataService = MovieDataService();
  List<Movie> searchedMovies = [];

  MoviesBloc() : super(LatestPageNumberMoviesState(1)) {
    on<FirstMoviesEvent>((event, emit) async {
      int pageNumber = (state as LatestPageNumberMoviesState).pageNumber;

      await _getMovies(emit, pageNumber);
    });

    on<DecreasePageMoviesEvent>((event, emit) async {
      int pageNumber = (state as LatestPageNumberMoviesState).pageNumber - 1;

      if (pageNumber > 0) await _getMovies(emit, pageNumber);
    });

    on<IncreasePageMoviesEvent>((event, emit) async {
      int pageNumber = (state as LatestPageNumberMoviesState).pageNumber - 1;

      await _getMovies(emit, pageNumber);
    });

    on<SearchPageMoviesEvent>((event, emit) async {
      emit(SearchedMoviesState(movies: searchedMovies));
    });
  }

  Future<void> _getMovies(Emitter<MoviesState> emit, int pageNumber) async {
    emit(LoadingMoviesState());

    try {
      final movies = await _dataService.getMovies(pageNumber: pageNumber);
      emit(LatestPageNumberMoviesState(pageNumber));

      emit(LoadedMoviesState(movies: movies));
    } catch (e) {
      emit(FailedMoviesState(errorMessage: e.toString()));
    }
  }

  Future<void> setMovies(Emitter<MoviesState> emit, List<Movie> movies) async {
    emit(LoadingMoviesState());

    try {
      emit(LoadedMoviesState(movies: movies));
    } catch (e) {
      emit(FailedMoviesState(errorMessage: e.toString()));
    }
  }
}
