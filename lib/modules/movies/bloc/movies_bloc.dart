import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/application_constants.dart';
import '../viewmodel/movie_list_view_model.dart';
import '../viewmodel/movie_view_model.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final _dataService = MovieListViewModel();
  List<MovieViewModel> searchedMovies = [];
  int pageNumber = 1;

  MoviesBloc() : super(InitialMoviesState()) {
    on<FirstMoviesEvent>((event, emit) async {
      pageNumber = 1;
      await _getMovies(emit, pageNumber);
    });

    on<DecreasePageMoviesEvent>((event, emit) async {
      if (pageNumber > 1) {
        pageNumber--;
        await _getMovies(emit, pageNumber);
      }
    });

    on<IncreasePageMoviesEvent>((event, emit) async {
      if (pageNumber < ApplicationConstants.apiTotalPagesNumber) {
        pageNumber++;
        await _getMovies(emit, pageNumber);
      }
    });

    on<SearchPageMoviesEvent>((event, emit) async {
      emit(SearchedMoviesState(movies: searchedMovies));
    });
  }

  Future<void> _getMovies(Emitter<MoviesState> emit, int pageNumber) async {
    emit(LoadingMoviesState());

    try {
      final movies = await _dataService.getMovies(pageNumber: pageNumber);
      emit(LoadedMoviesState(movies: movies));
    } catch (e) {
      emit(FailedMoviesState(errorMessage: e.toString()));
    }
  }

  Future<void> setMovies(
      Emitter<MoviesState> emit, List<MovieViewModel> movies) async {
    emit(LoadingMoviesState());

    try {
      emit(LoadedMoviesState(movies: movies));
    } catch (e) {
      emit(FailedMoviesState(errorMessage: e.toString()));
    }
  }
}
