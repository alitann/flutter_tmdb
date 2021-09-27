import 'dart:convert';

import '../../../core/constants/application_constants.dart';
import '../models/movie.dart';
import '../models/movie_service_response.dart';
import 'package:http/http.dart' as http;

class MovieDataService {
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
