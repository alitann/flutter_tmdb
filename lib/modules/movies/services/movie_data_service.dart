import '../../../core/init/network/network_base.dart';

import '../../../core/constants/application_constants.dart';
import '../models/movie.dart';
import '../models/movie_service_response.dart';

import 'imovie_data_service.dart';

class MovieDataService extends IMovieDataService {
  final String _baseUrl = ApplicationConstants.baseUrl +
      ApplicationConstants.discoverPath +
      ApplicationConstants.apiKeyParameter +
      ApplicationConstants.apiKey +
      '&sort_by=popularity.desc&page=';

  final NetworkBase _networkBase = NetworkBase();

  Future<List<Movie>> getMovies({int pageNumber = 1}) async {
    String url = _baseUrl + pageNumber.toString();
    final json = await _networkBase.get(url);
    return MovieServiceResponse.fromJson(json).results ?? [];
  }
}
