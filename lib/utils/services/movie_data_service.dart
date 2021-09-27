import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../core/constants/application_constants.dart';
import '../../modules/movies/models/movie.dart';
import '../../modules/movies/models/movie_service_response.dart';

class MovieDataService {
  // final _baseUrl =
  //     'https://api.themoviedb.org/3/discover/movie?api_key=4ff9d08260ed338797caa272d7df35dd&page=';

  final String _baseUrl = ApplicationConstants.baseUrl +
      ApplicationConstants.discoverPath +
      ApplicationConstants.apiKeyParameter +
      ApplicationConstants.apiKey +
      '&page=';

  Future<List<Movie>> getMovies({int pageNumber = 1}) async {
    var url = Uri.parse(_baseUrl + pageNumber.toString());
    final response = await http.get(url);

    if (response.statusCode == 200) {
      try {
        final json = jsonDecode(response.body);

        MovieServiceResponse movieServiceResponse =
            MovieServiceResponse.fromJson(json);

        return movieServiceResponse.results ?? [];
      } catch (e) {
        throw "Movies can not be received ${e.toString}";
      }
    } else {
      throw Exception(
          "Movies can not be received ${response.statusCode} - ${response.body.toString()}");
    }
  }
}
