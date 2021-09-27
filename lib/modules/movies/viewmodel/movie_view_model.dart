import '../../../core/constants/application_constants.dart';
import '../models/movie.dart';

class MovieViewModel {
  final Movie movie;

  MovieViewModel(this.movie);

  String get posterImageUrl =>
      ApplicationConstants.imageBaseUrl + movie.posterPath.toString();
}
