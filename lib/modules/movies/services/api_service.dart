import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../../core/constants/application_constants.dart';
import '../models/movie_service_response.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApplicationConstants.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String? baseUrl}) {
    dio.options = BaseOptions(
        receiveTimeout: 30000,
        connectTimeout: 30000,
        contentType: 'application/json');

    return _ApiService(dio, baseUrl: baseUrl);
  }

  @GET(ApplicationConstants.discoverPath +
      ApplicationConstants.apiKeyParameter +
      ApplicationConstants.apiKey)
  Future<MovieServiceResponse> getMovies(@Query("page") int pageNumber);
}
